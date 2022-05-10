import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef AsstCallback = Void Function(Int32, Pointer<Utf8>, Pointer<Void>);
typedef AsstCallbackFunc = void Function(int, String, dynamic);
typedef Assistant = Pointer<Void>;

// AsstCreateEx
typedef AsstCreateExFunc = Assistant Function(
    Pointer<Utf8>, Pointer<NativeFunction<AsstCallback>>, Pointer<Void>);
typedef AsstCreateExNative = NativeFunction<AsstCreateExFunc>;

// AsstCreate
typedef AsstCreateFunc = Assistant Function(Pointer<Utf8>);
typedef AsstCreateNative = NativeFunction<AsstCreateFunc>;

// AsstDestroy
typedef AsstDestroyFunc = void Function(Assistant);
typedef AsstDestroyNative = NativeFunction<Void Function(Assistant)>;

// AsstCatchDefault
typedef AsstCatchDefaultFunc = bool Function(Assistant);
typedef AsstCatchDefaultNative = NativeFunction<Bool Function(Assistant)>;

// AsstCatchEmulator
typedef AsstCatchEmulatorFunc = bool Function(Assistant);
typedef AsstCatchEmulatorNative = NativeFunction<Bool Function(Assistant)>;

// AsstCatchCustom
typedef AsstCatchCustomFunc = bool Function(Assistant, Pointer<Utf8> address);
typedef AsstCatchCustomNative
    = NativeFunction<Bool Function(Assistant, Pointer<Utf8>)>;

// AsstCatchFake
typedef AsstCatchFakeFunc = bool Function(Assistant);
typedef AsstCatchFakeNative = NativeFunction<Bool Function(Assistant)>;

// AsstAppendStartUp
typedef AsstAppendStartUpFunc = bool Function(Assistant);
typedef AsstAppendStartUpNative = NativeFunction<Bool Function(Assistant)>;

// AsstAppendFight
typedef AsstAppendFightFunc = bool Function(
    Assistant, Pointer<Utf8>, int, int, int);
typedef AsstAppendFightNative = NativeFunction<
    Bool Function(Assistant, Pointer<Utf8>, Int32, Int32, Int32)>;

// AsstAppendAward
typedef AsstAppendAwardFunc = bool Function(Assistant);
typedef AsstAppendAwardNative = NativeFunction<Bool Function(Assistant)>;

// AsstAppendVisit
typedef AsstAppendVisitFunc = bool Function(Assistant);
typedef AsstAppendVisitNative = NativeFunction<Bool Function(Assistant)>;

// AsstAppendMall
typedef AsstAppendMallFunc = bool Function(Assistant, bool);
typedef AsstAppendMallNative = NativeFunction<Bool Function(Assistant, Bool)>;

// AsstAppendProcessInfrast
typedef AsstAppendInfrastFunc = bool Function(
    Assistant, int, Pointer<Pointer<Utf8>>, int, Pointer<Utf8>, double);
typedef AsstAppendInfrastNative = NativeFunction<
    Bool Function(Assistant, Int32, Pointer<Pointer<Utf8>>, Int32,
        Pointer<Utf8>, Double)>;

// AsstAppendRecruit
typedef AsstAppendRecruitFunc = bool Function(
    Assistant, int, Pointer<Int32>, int, Pointer<Int32>, int, bool, bool);
typedef AsstAppendRecruitNative = NativeFunction<
    Bool Function(Assistant, Int32, Pointer<Int32>, Int32, Pointer<Int32>,
        Int32, Bool, Bool)>;

// AsstAppendRoguelike
typedef AsstAppendRoguelikeFunc = bool Function(Assistant, int);
typedef AsstAppendRoguelikeNative
    = NativeFunction<Bool Function(Assistant, Int32)>;

// AsstAppendDebug
typedef AsstAppendDebugFunc = bool Function(Assistant);
typedef AsstAppendDebugNative = NativeFunction<Bool Function(Assistant)>;

// AsstStartRecruitCalc
typedef AsstStartRecruitCalcFunc = bool Function(
    Assistant, Pointer<Int32>, int, bool);
typedef AsstStartRecruitCalcNative
    = NativeFunction<Bool Function(Assistant, Pointer<Int32>, Int32, Bool)>;

// AsstStart
typedef AsstStartFunc = bool Function(Assistant);
typedef AsstStartNative = NativeFunction<Bool Function(Assistant)>;

// AsstStop
typedef AsstStopFunc = bool Function(Assistant);
typedef AsstStopNative = NativeFunction<Bool Function(Assistant)>;

// AsstSetPenguinId
typedef AsstSetPenguinIdFunc = bool Function(Assistant, Pointer<Utf8>);
typedef AsstSetPenguinIdNative
    = NativeFunction<Bool Function(Assistant, Pointer<Utf8>)>;

// AssTGetImage
typedef AsstGetImageFunc = int Function(Assistant, Pointer<Void>, int);
typedef AsstGetImageNative
    = NativeFunction<Uint32 Function(Assistant, Pointer<Void>, Uint32)>;

// AsstCtrlerClick
typedef AsstCtrlerClickFunc = bool Function(Assistant, int, int, bool);
typedef AsstCtrlerClickNative
    = NativeFunction<Bool Function(Assistant, Int32, Int32, Bool)>;

// AsstGetVersion
typedef AsstGetVersionFunc = Pointer<Utf8> Function();
typedef AsstGetVersionNative = NativeFunction<AsstGetVersionFunc>;

class MaaCore {
  late Assistant _asst; // assistant
  late AsstCreateFunc _asstCreate;
  late AsstDestroyFunc _asstDestroy;
  late AsstCatchDefaultFunc _asstCatchDefault;
  late AsstCatchEmulatorFunc _asstCatchEmulator;
  late AsstCatchCustomFunc _asstCatchCustom;
  late AsstCatchFakeFunc _asstCatchFake;
  late AsstAppendStartUpFunc _asstAppendStartUp;
  late AsstAppendFightFunc _asstAppendFight;
  late AsstAppendAwardFunc _asstAppendAward;
  late AsstAppendVisitFunc _asstAppendVisit;
  late AsstAppendMallFunc _asstAppendMall;
  late AsstAppendInfrastFunc _asstAppendInfrast;
  late AsstAppendRecruitFunc _asstAppendRecruit;
  late AsstAppendRoguelikeFunc _asstAppendRoguelike;
  late AsstAppendDebugFunc _asstAppendDebug;
  late AsstStartRecruitCalcFunc _asstStartRecruitCalc;
  late AsstStartFunc _asstStart;
  late AsstStopFunc _asstStop;
  late AsstSetPenguinIdFunc _asstSetPenguinId;
  late AsstGetImageFunc _asstGetImage;
  late AsstCtrlerClickFunc _asstCtrlerClick;
  late AsstGetVersionFunc _asstGetVersion;
  late List<Pointer<NativeType>> _allocated;

  MaaCore(String libDir) {
    _allocated = [];
    // load lib
    // create assistant
    loadLib(libDir);
    _asst = _asstCreate(libDir.toNativeUtf8());
  }

  MaaCore.fromAssistant(Assistant asst, String libDir) {
    _allocated = [];
    _asst = asst;
    loadLib(libDir);
  }

  void loadLib(String libDir) {
    final _dylib = DynamicLibrary.open(libDir + '/libMeoAssistant.so');
    _asstCreate = _dylib.lookup<AsstCreateNative>('AsstCreate').asFunction();
    _asstDestroy = _dylib.lookup<AsstDestroyNative>('AsstDestroy').asFunction();
    _asstCatchDefault =
        _dylib.lookup<AsstCatchDefaultNative>('AsstCatchDefault').asFunction();
    _asstCatchEmulator = _dylib
        .lookup<AsstCatchEmulatorNative>('AsstCatchEmulator')
        .asFunction();
    _asstCatchCustom =
        _dylib.lookup<AsstCatchCustomNative>('AsstCatchCustom').asFunction();
    _asstCatchFake =
        _dylib.lookup<AsstCatchFakeNative>('AsstCatchFake').asFunction();
    _asstAppendStartUp = _dylib
        .lookup<AsstAppendStartUpNative>('AsstAppendStartUp')
        .asFunction();
    _asstAppendFight =
        _dylib.lookup<AsstAppendFightNative>('AsstAppendFight').asFunction();
    _asstAppendAward =
        _dylib.lookup<AsstAppendAwardNative>('AsstAppendAward').asFunction();
    _asstAppendVisit =
        _dylib.lookup<AsstAppendVisitNative>('AsstAppendVisit').asFunction();
    _asstAppendMall =
        _dylib.lookup<AsstAppendMallNative>('AsstAppendMall').asFunction();
    _asstAppendInfrast = _dylib
        .lookup<AsstAppendInfrastNative>('AsstAppendInfrast')
        .asFunction();
    _asstAppendRecruit = _dylib
        .lookup<AsstAppendRecruitNative>('AsstAppendRecruit')
        .asFunction();
    _asstAppendRoguelike = _dylib
        .lookup<AsstAppendRoguelikeNative>('AsstAppendRoguelike')
        .asFunction();
    _asstAppendDebug =
        _dylib.lookup<AsstAppendDebugNative>('AsstAppendDebug').asFunction();
    _asstStartRecruitCalc = _dylib
        .lookup<AsstStartRecruitCalcNative>('AsstStartRecruitCalc')
        .asFunction();
    _asstStart = _dylib.lookup<AsstStartNative>('AsstStart').asFunction();
    _asstStop = _dylib.lookup<AsstStopNative>('AsstStop').asFunction();
    _asstSetPenguinId =
        _dylib.lookup<AsstSetPenguinIdNative>('AsstSetPenguinId').asFunction();
    _asstGetImage =
        _dylib.lookup<AsstGetImageNative>('AsstGetImage').asFunction();
    _asstCtrlerClick =
        _dylib.lookup<AsstCtrlerClickNative>('AsstCtrlerClick').asFunction();
    _asstGetVersion =
        _dylib.lookup<AsstGetVersionNative>('AsstGetVersion').asFunction();

  }

  void destroy() {
    while (_allocated.isNotEmpty) {
      final ptr = _allocated.removeLast();
      malloc.free(ptr);
    }
    _asstDestroy(_asst);
  }

  bool catchDefault() {
    return _asstCatchDefault(_asst);
  }

  bool catchEmulator() {
    return _asstCatchEmulator(_asst);
  }

  bool catchCustom(String addr) {
    final strPtr = addr.toNativeUtf8();
    return _asstCatchCustom(_asst, strPtr);
  }

  bool catchFake() {
    return _asstCatchFake(_asst);
  }

  bool appendStartUp() {
    return _asstAppendStartUp(_asst);
  }

  bool appendFight(String stage,
      {int maxMedicine = 0, int maxStone = 0, required int maxTimes}) {
    final stagePtr = stage.toNativeUtf8();
    return _asstAppendFight(_asst, stagePtr, maxMedicine, maxStone, maxTimes);
  }

  bool appendAward() {
    return _asstAppendAward(_asst);
  }

  bool appendVisit() {
    return _asstAppendVisit(_asst);
  }

  bool appendMall(bool withShopping) {
    return _asstAppendMall(_asst, withShopping);
  }

  bool appendInfrast(
      {required int workMode,
      required List<String> orders,
      required String useOfDrones,
      required double droneThreshold}) {
    final orderSize = orders.length;
    final useOfDronesPtr = useOfDrones.toNativeUtf8();
    final ordersPtr = _toNativeStringArray(orders);

    return _asstAppendInfrast(
      _asst,
      workMode,
      ordersPtr,
      orderSize,
      useOfDronesPtr,
      droneThreshold,
    );
  }

  bool appendRecruit(
      {required int maxTimes,
      required List<int> selectLevels,
      required List<int> confirmLevels,
      required bool needRefresh,
      required bool useExpedited}) {
    final selectLen = selectLevels.length;
    final confirmLen = confirmLevels.length;

    final selectLevelsPtr = _toNativeInt32Array(selectLevels);
    final confirmLevelsPtr = _toNativeInt32Array(confirmLevels);

    return _asstAppendRecruit(
      _asst,
      maxTimes,
      selectLevelsPtr,
      selectLen,
      confirmLevelsPtr,
      confirmLen,
      needRefresh,
      useExpedited,
    );
  }

  bool appendRougelike(int mode) {
    return _asstAppendRoguelike(_asst, mode);
  }

  bool appendDebug() {
    return _asstAppendDebug(_asst);
  }

  bool appendStartRecruitCalc(
      {required List<int> selectLevels, required bool setTime}) {
    final requiredLen = selectLevels.length;
    final levelsPtr = _toNativeInt32Array(selectLevels);
    return _asstStartRecruitCalc(_asst, levelsPtr, requiredLen, setTime);
  }
  
  bool start() {
    return _asstStart(_asst);
  }

  bool stop() {
    var suc = false;
    try {
      suc = _asstStop(_asst);
    } catch (exception) {
      print("error occured");
    }
    finally {
      while (_allocated.isNotEmpty) {
        final ptr = _allocated.removeLast();
        malloc.free(ptr);
      }
    }
    return suc; 
  }


  bool setPenguinId(String id) {
    return _asstSetPenguinId(_asst, id.toNativeUtf8());
  }


  bool asstCtrlerClick(int x, int y, bool block) {
    return _asstCtrlerClick(_asst, x, y, block);
  }

  Pointer<Pointer<Utf8>> _toNativeStringArray(List<String> strArray) {
    List<Pointer<Utf8>> strPtrs =
        strArray.map((str) => str.toNativeUtf8()).toList();
    final Pointer<Pointer<Utf8>> ptrPtr =
        malloc.allocate(sizeOf<Pointer<Utf8>>() * strPtrs.length);
    for (int i = 0; i < strPtrs.length; i++) {
      ptrPtr[i] = strPtrs[i];
    }
    _allocated.add(ptrPtr);
    return ptrPtr;
  }


  Pointer<Int32> _toNativeInt32Array(List<int> numbers) {
    final ptr = malloc.allocate<Int32>(sizeOf<Int32>() * numbers.length);
    for (var i = 0; i < numbers.length; i++) {
      ptr[i] = numbers[i];
    }
    _allocated.add(ptr);
    return ptr;
  }
  static AsstCreateExFunc loadAsstCreateEx(String libDir) {
    final lib = DynamicLibrary.open(libDir + '/libMeoAssistant.so');
    return lib.lookup<AsstCreateExNative>('AsstCreateEx').asFunction();
  }
}

