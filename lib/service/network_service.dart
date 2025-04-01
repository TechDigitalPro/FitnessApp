import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/request/get_my_plan_req.dart';
import '../model/request/get_plan_req.dart';
import '../model/request/get_workouts_req.dart';
import '../model/request/login_req.dart';
import '../model/request/register_req.dart';
import '../model/request/resend_verification_req.dart';
import '../model/request/set_plan_req.dart';
import '../model/request/verify_email_req.dart';
import '../model/response/api_res.dart';
import '../model/response/common_res.dart';
import '../model/response/get_news_res.dart';
import '../model/response/get_plan_res.dart';
import '../model/response/get_trainers_res.dart';
import '../model/response/get_workouts_res.dart';
import '../model/response/login_res.dart';
import '../model/response/verify_email_res.dart';
import '../utils/api_utils.dart';

class NetworkService {
  var dio = Dio(); 

  Future doPostRequest(String url, {dynamic param, dynamic body, dynamic token}) async {
    try {
      var formData = FormData();
      if(body != null){
        formData = FormData.fromMap(body);
      }
      if(token != null) {
        dio.options.headers["authorization"] = "Bearer $token";
      }

      Response response = await dio.post(
        url,
        queryParameters: param,
        data: body == null ? '' : formData,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
        }),
      );

      var resData = response.data;
      return resData;

    } catch (e) {
      debugPrint(e.toString());
      if (e is DioException) {
        return e.response?.data;
      }else {
        return null;
      }
    }
  }

  Future doGetRequest(String url, {dynamic param, dynamic token}) async {
    try {
      if(token != null) {
        dio.options.headers["authorization"] = "Bearer $token";
      }
      Response response = await dio.get(
        url,
        queryParameters: param,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
        }),
      );

      var resData = response.data;
      return resData;

    } catch (e) {
      debugPrint(e.toString());
      if (e is DioException) {
        return e.response?.data;
      }else {
        return null;
      }
    }
  }

  //Auth
  Future<LoginRes?> doLogin(LoginReq req) async {
    var res = await doPostRequest(ApiUtils.urlLogin, body: req.toJson());
    LoginRes? response;
    try{
      response = LoginRes.fromJson(res);
    }catch (e){
      debugPrint(e.toString());
    }
    return response;
  }

  Future<LoginRes?> doRegister(RegisterReq req) async {
    var res = await doPostRequest(ApiUtils.urlRegister, body: req.toJson());
    LoginRes? response;
    try{
      response = LoginRes.fromJson(res);
    }catch (e){
      debugPrint(e.toString());
    }
    return response;
  }

  Future<VerifyEmailRes?> doVerifyEmail(VerifyEmailReq req) async {
    var res = await doPostRequest(ApiUtils.urlVerifyEmail, body: req.toJson());
    VerifyEmailRes? response;
    try{
      response = VerifyEmailRes.fromJson(res);
    }catch (e){
      debugPrint(e.toString());
    }
    return response;
  }

  Future<ApiRes?> doResendVerifyEmail(ResendVerificationReq req) async {
    var res = await doPostRequest(ApiUtils.urlResendVerificationEmail, body: req.toJson());
    ApiRes? response;
    try{
      response = ApiRes.fromJson(res);
    }catch (e){
      debugPrint(e.toString());
    }
    return response;
  }

  Future<GetTrainersRes?> doGetTrainers(String token) async {
    var res = await doPostRequest(ApiUtils.urlGetTrainerList, token: token);
    GetTrainersRes? response;
    try{
      response = GetTrainersRes.fromJson(res);
    }catch (e){
      debugPrint(e.toString());
    }
    return response;
  }

  Future<GetWorkoutsRes?> doGetTrainerWorkouts(String token, GetWorkoutsReq req) async {
    var res = await doPostRequest(ApiUtils.urlGetWorkoutList, token: token, body: req.toJson());
    GetWorkoutsRes? response;
    try{
      response = GetWorkoutsRes.fromJson(res);
    }catch (e){
      debugPrint(e.toString());
    }
    return response;
  }

  Future<GetWorkoutsRes?> doGetWorkouts(String token) async {
    var res = await doPostRequest(ApiUtils.urlGetWorkoutList, token: token);
    GetWorkoutsRes? response;
    try{
      response = GetWorkoutsRes.fromJson(res);
    }catch (e){
      debugPrint(e.toString());
    }
    return response;
  }

  Future<GetNewsRes?> doGetNews(String token) async {
    var res = await doPostRequest(ApiUtils.urlGetNewsList, token: token);
    GetNewsRes? response;
    try{
      response = GetNewsRes.fromJson(res);
    }catch (e){
      debugPrint(e.toString());
    }
    return response;
  }

  Future<GetPlansRes?> doGetPlans(String token, GetPlanReq req) async {
    var res = await doPostRequest(ApiUtils.urlGetPlanList, token: token, body: req.toJson());
    GetPlansRes? response;
    try{
      response = GetPlansRes.fromJson(res);
    }catch (e){
      debugPrint(e.toString());
    }
    return response;
  }

  Future<CommonRes?> doSetPlans(String token, SetPlanReq req) async {
    var res = await doPostRequest(ApiUtils.urlSetPlan, token: token, body: req.toJson());
    CommonRes? response;
    try{
      response = CommonRes.fromJson(res);
    }catch (e){
      debugPrint(e.toString());
    }
    return response;
  }

  Future<GetPlansRes?> doGetMyPlans(String token, GetMyPlanReq req) async {
    var res = await doPostRequest(ApiUtils.urlGetMyPlans, token: token, body: req.toJson());
    GetPlansRes? response;
    try{
      response = GetPlansRes.fromJson(res);
    }catch (e){
      debugPrint(e.toString());
    }
    return response;
  }
}
