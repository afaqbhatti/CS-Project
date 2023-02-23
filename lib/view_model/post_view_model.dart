import 'package:flutter/material.dart';
import 'package:connect_social/model/NpDateTime.dart';
import 'package:connect_social/model/Post.dart';
import 'package:connect_social/model/User.dart';
import 'package:connect_social/model/apis/api_response.dart';
import 'package:connect_social/model/directories/post_repo.dart';
import 'package:connect_social/utils/Utils.dart';


class PostViewModel extends ChangeNotifier {
  Post? postResponse = Post();
  PostRepo _postRepo = PostRepo();

  PostViewModel({this.postResponse});

  ApiResponse fetchAllPostStatus = ApiResponse();
  ApiResponse get getAllPostStatus => fetchAllPostStatus;

  List<Post?> _publicPost = [];
  List<Post?> get getPublicPosts => _publicPost;

  void setPublicPost(List<Post> posts) {
    _publicPost = posts;
    notifyListeners();
  }

  Future fetchAllPost(dynamic data, String token) async {

    dynamic response = await _postRepo.getPublicPostApi(data, token);
    ApiResponse _fetchAllPostStatus=ApiResponse.loading('Fetching posts');
    fetchAllPostStatus = _fetchAllPostStatus;
    try {
      List<Post?> publicPost = [];
      response['data'].forEach((item) {
        item['createdat'] = NpDateTime.fromJson(item['createdat']);
        item['user'] = User.fromJson(item['user']);
        if (item['assets'].toString() == '[]') {
          item['assets'] = new PostAsset();
        } else {
          item['assets']['createdat'] = NpDateTime.fromJson(item['assets']['createdat']);
          item['assets'] = PostAsset.fromJson(item['assets']);
        }
        List<String> privacies=[];
        for (var word in item['privacies']) {
          privacies.add(word['privacy']);
        }
        item['privacy']=privacies;
        publicPost.add(Post.fromJson(item));
      });
      _publicPost = publicPost;
      _fetchAllPostStatus = ApiResponse.completed(_publicPost);
      fetchAllPostStatus=_fetchAllPostStatus;
      notifyListeners();

    } catch (e) {
      print('post : ${e}');
      //Utils.toastMessage('${response['message']}');
      _fetchAllPostStatus = ApiResponse.error('Some error occurred!');
      fetchAllPostStatus=_fetchAllPostStatus;
      notifyListeners();
    }
  }

  Future fetchTwoMorePosts(dynamic data, String token) async {

    dynamic response = await _postRepo.getPublicPostApi(data, token);
    print('response --- ${response['data']}');
    try {
      List<Post?> publicPost = [];
      response['data'].forEach((item) {

        item['createdat'] = NpDateTime.fromJson(item['createdat']);

        item['user'] = User.fromJson(item['user']);

        if (item['assets'].toString() != '[]') {
          item['assets']['createdat'] = NpDateTime.fromJson(item['assets']['createdat']);
          item['assets'] = PostAsset.fromJson(item['assets']);
        } else {
          item['assets'] = new PostAsset();
        }
        List<String> privacies=[];
        for (var word in item['privacies']) {
          privacies.add(word['privacy']);
        }
        item['privacy']=privacies;
        publicPost.add(Post.fromJson(item));
      });
      print('done');
      return publicPost;
    } catch (e) {
      print(e);
    }
  }


  Post? _singlePost = new Post();
  Post? get getSinglePost => _singlePost;

  ApiResponse fetchSinglePostStatus = ApiResponse();
  ApiResponse get getSinglePostStatus => fetchSinglePostStatus;

  void setSinglePost(Post post) {
    _singlePost = post;
    notifyListeners();
  }

  Future fetchSinglePost(dynamic data, String token) async {
    ApiResponse _fetchSinglePostStatus=ApiResponse.loading('Fetching post');
    fetchSinglePostStatus = _fetchSinglePostStatus;

    dynamic response = await _postRepo.fetchSinglePostApi(data, token);
    try {
      dynamic item = response['data'];
      item['createdat'] = NpDateTime.fromJson(item['createdat']);
      item['user'] = User.fromJson(item['user']);
      if (item['assets'].toString() != '[]') {
        item['assets']['createdat'] = NpDateTime.fromJson(item['assets']['createdat']);
        item['assets'] = PostAsset.fromJson(item['assets']);
      } else {
        item['assets'] = new PostAsset();
      }
      Post? post = Post.fromJson(item);
      _singlePost = post;

      _fetchSinglePostStatus = ApiResponse.completed(_singlePost);
      fetchSinglePostStatus = _fetchSinglePostStatus;

      notifyListeners();

    } catch (e) {
      print(e.toString());
      Utils.toastMessage('${response['message']}');

      _fetchSinglePostStatus = ApiResponse.error('Some error occurred!');
      fetchSinglePostStatus=_fetchSinglePostStatus;
      notifyListeners();
    }

  }

  Future deletePost(dynamic data, String token) async {
    dynamic response = await _postRepo.deleteMyPostApi(data, token);
    try {
      Utils.toastMessage(response['message']);
    } catch (e) {
      Utils.toastMessage('${response['message']}');
    }
  }
}

class MyPostViewModel extends ChangeNotifier {
  Post? postResponse = Post();
  PostRepo _postRepo = PostRepo();

  MyPostViewModel({this.postResponse});

  List<Post?> _myPost = [];

  List<Post?> get getMyPosts => _myPost;

  set setMyPosts(List<Post> friendlist) {
    _myPost = friendlist;
    notifyListeners();
  }

  Future fetchMyPosts(dynamic data, String token) async {
    final response = await _postRepo.getMyPostApi(data, token);
    try {
      print(response['data']);
      List<Post?> myPost = [];
      response['data'].forEach((item) {
        item['createdat'] = NpDateTime.fromJson(item['createdat']);
        item['user'] = User.fromJson(item['user']);
        if (item.containsKey('assets')) {
          if (item['assets'].toString() != '[]') {
            item['assets']['createdat'] =
                NpDateTime.fromJson(item['assets']['createdat']);
            item['assets'] = PostAsset.fromJson(item['assets']);
          } else {
            item['assets'] = new PostAsset();
          }
        } else {
          item['assets'] = new PostAsset();
        }

        List<String> privacies=[];
        for (var word in item['privacies']) {
          privacies.add(word['privacy']);
        }
        item['privacy']=privacies;
        myPost.add(Post.fromJson(item));
      });
      _myPost = myPost;
    } catch (e) {
      //Utils.toastMessage('${response['message']}');
    }
    notifyListeners();

  }
   Future fetchMyMorePosts(dynamic data, String token) async {
     final response = await _postRepo.getMyPostApi(data, token);
     List<Post?> myPost = [];
     response['data'].forEach((item) {
       item['createdat'] = NpDateTime.fromJson(item['createdat']);
       item['user'] = User.fromJson(item['user']);
       if (item.containsKey('assets')) {
         if (item['assets'].toString() != '[]') {
           item['assets']['createdat'] = NpDateTime.fromJson(item['assets']['createdat']);
           item['assets'] = PostAsset.fromJson(item['assets']);
         } else {
           item['assets'] = new PostAsset();
         }
       } else {
         item['assets'] = new PostAsset();
       }
       List<String> privacies=[];
       for (var word in item['privacies']) {
         privacies.add(word['privacy']);
       }
       item['privacy']=privacies;
       print(item);
       myPost.add(Post.fromJson(item));
     });
     return myPost;
   }


  Future createPost(Map data, String token) async {
    dynamic response;
    response = await _postRepo.createPostApi(data, token);
    return response;
  }
}
