﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//kabam.rotmg.ui.view.CurrentCharacterMediator

package kabam.rotmg.ui.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.classes.model.ClassesModel;
    import kabam.rotmg.core.signals.SetScreenSignal;
    import kabam.rotmg.game.signals.PlayGameSignal;
    import kabam.rotmg.ui.signals.ChooseNameSignal;
    import kabam.rotmg.ui.signals.NameChangedSignal;
    import kabam.rotmg.packages.control.InitPackagesSignal;
    import kabam.rotmg.packages.control.BeginnersPackageAvailableSignal;
    import kabam.rotmg.packages.control.PackageAvailableSignal;
    import kabam.rotmg.promotions.model.BeginnersPackageModel;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import com.company.assembleegameclient.screens.NewCharacterScreen;
    import com.company.assembleegameclient.appengine.SavedCharacter;
    import kabam.rotmg.classes.model.CharacterClass;
    import kabam.rotmg.game.model.GameInitData;

    public class CurrentCharacterMediator extends Mediator 
    {

        [Inject]
        public var view:CharacterSelectionAndNewsScreen;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var classesModel:ClassesModel;
        [Inject]
        public var setScreen:SetScreenSignal;
        [Inject]
        public var playGame:PlayGameSignal;
        [Inject]
        public var chooseName:ChooseNameSignal;
        [Inject]
        public var nameChanged:NameChangedSignal;
        [Inject]
        public var initPackages:InitPackagesSignal;
        [Inject]
        public var beginnersPackageAvailable:BeginnersPackageAvailableSignal;
        [Inject]
        public var packageAvailable:PackageAvailableSignal;
        [Inject]
        public var beginnerModel:BeginnersPackageModel;
        [Inject]
        public var openDialog:OpenDialogSignal;


        override public function initialize():void
        {
            this.view.initialize(this.playerModel);
            this.view.close.add(this.onClose);
            this.view.newCharacter.add(this.onNewCharacter);
            this.view.showClasses.add(this.onNewCharacter);
            this.view.chooseName.add(this.onChooseName);
            this.view.playGame.add(this.onPlayGame);
            this.nameChanged.add(this.onNameChanged);
            this.beginnersPackageAvailable.add(this.onBeginner);
            this.initPackages.dispatch();
        }

        private function onPackage():void
        {
            this.view.showPackageButton();
        }

        private function onBeginner():void
        {
            this.view.showBeginnersOfferButton();
        }

        override public function destroy():void
        {
            this.nameChanged.remove(this.onNameChanged);
            this.beginnersPackageAvailable.remove(this.onBeginner);
            this.view.close.remove(this.onClose);
            this.view.newCharacter.remove(this.onNewCharacter);
            this.view.chooseName.remove(this.onChooseName);
            this.view.showClasses.remove(this.onNewCharacter);
            this.view.playGame.remove(this.onPlayGame);
        }

        private function onNameChanged(_arg_1:String):void
        {
            this.view.setName(_arg_1);
        }

        private function onNewCharacter():void
        {
            this.setScreen.dispatch(new NewCharacterScreen());
        }

        private function onClose():void
        {
            this.setScreen.dispatch(new TitleView());
        }

        private function onChooseName():void
        {
            this.chooseName.dispatch();
        }

        private function onPlayGame():void
        {
            var _local_1:SavedCharacter = this.playerModel.getCharacterByIndex(0);
            this.playerModel.currentCharId = _local_1.charId();
            var _local_2:CharacterClass = this.classesModel.getCharacterClass(_local_1.objectType());
            _local_2.setIsSelected(true);
            _local_2.skins.getSkin(_local_1.skinType()).setIsSelected(true);
            var _local_3:GameInitData = new GameInitData();
            _local_3.createCharacter = false;
            _local_3.charId = _local_1.charId();
            _local_3.isNewGame = true;
            this.playGame.dispatch(_local_3);
        }


    }
}//package kabam.rotmg.ui.view

