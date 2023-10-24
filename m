Return-Path: <virtio-dev-return-14017-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21453C25B48
	for <virtio-dev@archiver.kernel.org>; Tue, 24 Oct 2023 10:51:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6A33188E0D
	for <virtio-dev@archiver.kernel.org>; Tue, 24 Oct 2023 10:51:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 629269869CA
	for <virtio-dev@archiver.kernel.org>; Tue, 24 Oct 2023 10:51:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5385B9869A6; Tue, 24 Oct 2023 10:51:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4241C9869A2;
	Tue, 24 Oct 2023 10:51:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMatWeDJVjzkCsD5RHMheRWa3YVaUCo0oFee3dKBtE+D/hjFyJVyOAoBMni7/3Q24bYMAnHZ/NN9sETCZnv9X42CFEeRtzJpjuv30iruaW7ghasa2FInfhcdmGCrntEL79X+0qPRhwMngJVC4dBf8VZuNVo/5fEvHYzSzEsB5ZyBCxwjrwolKYdCIK01dsKKeyQrgn2XtKdFxxVmiftvkKsEXFm4m+AIB2KVB5cEdQqWLdqeoR46CNLf2MzuVtQezPaEj4h5ir6mfPZwJkAvmvylbg9DUYRF9E+OijsDZymmNmq7xUmH4ffj+2+Ytx9IIWwZnls4ASOD15BZpk05Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Si7UmzOk3USoTAw0lQ/Q0ZaYkO5AuhPGt+fJSRmSQ+0=;
 b=QVKWVFAWqVfJBUyy775bqBTjY9wCkoX2d9JpaDGKBBtcfl4LddJENbT2hqfW/Edr1VrDPo1IYXgvVihaxUQ0q3zdeu6hLa74BaKkjzxIhvBUFW7uB5M8WSykm56Cujd0pXWMloQzeQvInt8Sq665GE2do8qYmiffsGm5uX2sMpDTqrv8hquyFzFMwoxtHPUUJIDFKFIeUm+K+TmdR1QNsCX6kKSAU7I+147pHLBspMQOZwG9W4cnWwIY/btkG2EuXOpT2eLRcbuWYi6+kyrSh8FXghlmQJOBww+4SSFLPQzs1YSW8hjCJEuE29OneAec4OhWKlgI601OuXk3jpK0fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Airlie <airlied@redhat.com>, Gurchetan Singh
	<gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huang,
 Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia" <Julia.Zhang@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>
Thread-Topic: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES
Thread-Index: AQHaA9H0ua9xMq0gbkqU60djCdCUsrBW4XZQgABREYCAAC/xEIABYZmAgAADs4A=
Date: Tue, 24 Oct 2023 10:51:45 +0000
Message-ID:
 <PH0PR12MB5481BAA4566F77FBEA8B712CDCDFA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <20231021035111.650248-2-Jiqian.Chen@amd.com>
 <PH0PR12MB548182FF345FE7D1DE0D89C1DCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584997339FBFF8E8DF007755E7D8A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481DBD22233808AA9497ADBDCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584959DE2A88F4968ECC6740E7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To:
 <BL1PR12MB584959DE2A88F4968ECC6740E7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB5676:EE_
x-ms-office365-filtering-correlation-id: 3ca7e02c-c72b-4ff7-9d00-08dbd47f3755
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 epY6qGO9lhiH2sc4JaSLQ4uwnd7Z5/iK01JpzDdEa8wZoIQdnsYYROBn9MmjC67XMHeYqcoXfN0Z8wlLO8yQ703ruN3SNz3YwoV197ZYgpwIDpYqav6maFgWpA8DtunzfmrRcltM1/VeENUEtLMaZK/nI1zI5AjY8HDCTwqXqcX/0Z5KmbRWNSsaeO3BOp5u7sfrd4jsS1HIEPqamZToC41IZgnD2EUI9WFvCDviDF8mnmTQ2p7U4+ZctGqA5K4sHLtIf39igPWWHW1GxB6j68mhPqzZoqSX6yiu6ll3Oay1RLSnnCDTqd2ELPPLCUFSvYtWd13REKvdM5XYa8sgOY4hyc42K6A+FNB+SRAY7AwNUuzT363PCqNg6pUEFxaR8+15MkL0cI0ACNs+xLb3h9nW8FcMNi77TGVuCmR7C37lx/rxkCwNkdIZuLsJR1BPAx8XNIL5RX+9peh+giFHAix8nwnn2uyhg/CVa1oL7WgSKIOTnvrtIYQFlXrnoE0W5y5xNOdldzE5zeu13ACvgPz1gnujqdPJIX8D/am5dYxvFO7W0WV0AZ+HOoAuwcWbsTM/Ram22sS61lKC2dIS6DC2cMUW3dFE3RsGcBf06NBSkArlw7XWe/ENnEvok/q+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(86362001)(38100700002)(2906002)(71200400001)(8936002)(8676002)(316002)(66946007)(76116006)(41300700001)(66446008)(66476007)(66556008)(7416002)(64756008)(53546011)(52536014)(4326008)(5660300002)(54906003)(6916009)(9686003)(26005)(83380400001)(6506007)(478600001)(33656002)(7696005)(55016003)(122000001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFd3YXZOSlIvaUNST1JNWnc0Z3g3YitJMXN1bGV1MlB1WTJOV3JRUFJUWWpT?=
 =?utf-8?B?TWx1aDZIUitYYVJpSkxuMlZOY3EvbWFjRW5YZFhBczU2am9LVUk0ZW5iZXZt?=
 =?utf-8?B?RWQ0c3FRTlMwUmRwUi9nczk2YVhUcHRnNFNYU05hNVE4bnQrZnVYZXYwdXh2?=
 =?utf-8?B?WlhZak9EZFFXRzdFMDJFL0ZYVGhoZFdtOXRTUUhkU3Z1bTlBb1p3VmhpNnZY?=
 =?utf-8?B?M0tuY0JDVUExKzZhejI5Y2VWM1V6WXlTaWorb0UyZTd1cElCZS94blRSenhp?=
 =?utf-8?B?aDJMcjZENENkS2xMVUxGTmlLVHdpTkhxRitERUkvWDQ1MFlpb3Fxa1dtNTJU?=
 =?utf-8?B?elQ0TkpYOEhyWWZPRFo5TThMRHRXM2U0cHl5VndPMmlIY1RNeDhQRm04NTFD?=
 =?utf-8?B?MUN1VmpQU2VuelFsOTBRd2Fnanhwd1lpU1NaOVlFbXZwWW8zbUxwZ29aZlR5?=
 =?utf-8?B?ekUxQUt2SWFGY2twV3FXQm5wU3RuY1lwVGZRWStGRnFRMG1xd015SksxQ2VZ?=
 =?utf-8?B?aGhlYWJRN2drREFyeEFkNGp5aFEzYmE2MVNnNVc4UTF6SDQ4em8zbDgrbE5M?=
 =?utf-8?B?YVZWcHBnNFJocGdxQVRYem5hSGxxUFRHcVo5d2VzS09hc25TK21xSHc5THor?=
 =?utf-8?B?bkRhUmt2eXJhVnVCWkFBRVpaSG90SGRjR0dkaXFMcmF4TllQV3owTVBNTmkw?=
 =?utf-8?B?WHpzdThQV1hETUI2OGJSZzVlY0c3anJKdlhQOHBvVjQ0Rms2STVUY29tRlA5?=
 =?utf-8?B?ZzN2ZFJITTlKeVpRS0dsT3BPMG4xdUhXMjJnWGpRWXZHY1N2MFRGSEtiK0Zl?=
 =?utf-8?B?dGlLblVTbGtLTTJsZlpDMzl1bFN2VzU0ZjIxNVl3TFZPVG5nUzZWc1ZXZXBp?=
 =?utf-8?B?VVNDY0NSSVVLbjR2Tnd5Mm5aK05FZVJzRUlSQWJhSTJoOENUdXpQMVlKMDNE?=
 =?utf-8?B?a084OGFuRm1KK2VldHNuM1BUSkkzMHBLMllla1ErZEViYWJ0aHVuVHZLSm02?=
 =?utf-8?B?RFYxTVVWUFNnQ2FYbTBZM0ZrZHJkUEVsdVA1c2FiWFFpZHVUT2E3cnJ3dDRN?=
 =?utf-8?B?TmdjSTl5SkhEalV0STFBbWpHNDFUcVFCMUpXTXNHeTh0Y25Yc3ZqaUhQSjNV?=
 =?utf-8?B?LzFwSFYyYzlPeTRIZXY4Q0RBVWh2OUptQ0Qxc2FaWHhJTFdYL0xDMk4vanpZ?=
 =?utf-8?B?QzNFUzZyWEZvUVFOMkJmMEhBamR2emVZaFpKdmRrM24rdUNKMHh4SzArT2tt?=
 =?utf-8?B?YlI2dmlaRTR0RkNMTUp0YmNGR0VQN2dHK0ZFWEpRYzdUTlFLVXpzT054UnV0?=
 =?utf-8?B?VEtvUzNodnNpbkJDS3QyYStFVEtSeDhveDMwTUxHZG8vdnRkQVljZnRWYjJ5?=
 =?utf-8?B?ZFF1bU5KdnBtd2RjT0RFMmpsN0xSZEprczM3Z0xGNGVxVW10Ymx0MXJydGNv?=
 =?utf-8?B?Nk4rZUNSekxORTlhNERoKzlURGRnWW9lek5wSW1hZi8xVmJBTFpaaXg5NGs1?=
 =?utf-8?B?UFVtTi8wRW5rcTdTSnBOWjJLcmh4V1AvS3FWYjdNck1oOVN1WVJTRk4zMlpm?=
 =?utf-8?B?bS85dDBQQ2hjUVlZeWZoV1RuV0FtaUJJYXB3dDRndnlLbEp2QkdubEFWY2NI?=
 =?utf-8?B?VU5McU5uUzB1QURyKzNpNjMxcnJZL3A5cmtDTE5ZdHYwZE9VOU4xaFYwLzcz?=
 =?utf-8?B?NVloZm1EMmwxM2p2bVVSWTBTeUtrVUpCQThndUN4YzFaTmFxQ0swL2Nackpu?=
 =?utf-8?B?dGM1L0doNUNOa0lQczBNczEyb2ZoMkFrZnlhcmpCWlZmVWorakpkRDhXbmsx?=
 =?utf-8?B?T3ZIOFNwcDNBekFWVTRSMXd5eTl3a1R3UHJwaGpOQXVVMys2RC9BZWxpRStr?=
 =?utf-8?B?LzFRTmhCcUt4RXJqQTJwb3pnbzdsaXNvemNBRGdCYktzQS9lWTFiRzJyR3RX?=
 =?utf-8?B?cTNZeElPbjNBNjRDZjEwdzBtcC9zeTFGTjVvTDZQcVprRk8ySXJ2SlBrMVBz?=
 =?utf-8?B?Y0RuSTNEWDczS2RyU0JsTzhsT3FCbWhUVnN1Y1pFNXR2SGVOM2RBejVCU09P?=
 =?utf-8?B?Qm1kdXZqalFCTG5INE1BR1g4Ni9PVVc0VG9EYmF0ZTdMdWZBTkpteXpmSWxO?=
 =?utf-8?Q?X6tA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca7e02c-c72b-4ff7-9d00-08dbd47f3755
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 10:51:45.6843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7YN+B29Sl/nPUphnCy18sQekR0R2UcU427mgr8FdF5rAJS5oyg8CrTl8t0X7YAJfzJBQCXHgtViMzTTui3ZkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5676
Subject: [virtio-dev] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

DQo+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4gU2VudDogVHVl
c2RheSwgT2N0b2JlciAyNCwgMjAyMyA0OjA2IFBNDQo+IA0KPiBPbiAyMDIzLzEwLzIzIDIxOjM1
LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4NCj4gPj4gRnJvbTogQ2hlbiwgSmlxaWFuIDxKaXFp
YW4uQ2hlbkBhbWQuY29tPg0KPiA+PiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjMsIDIwMjMgNDow
OSBQTQ0KPiA+DQo+ID4+PiBJIHRoaW5rIHRoaXMgY2FuIGJlIGRvbmUgd2l0aG91dCBpbnRyb2R1
Y2luZyB0aGUgbmV3IHJlZ2lzdGVyLg0KPiA+Pj4gQ2FuIHlvdSBwbGVhc2UgY2hlY2sgaWYgdGhl
IFBNIHJlZ2lzdGVyIGl0c2VsZiBjYW4gc2VydmUgdGhlIHB1cnBvc2UNCj4gPj4+IGluc3RlYWQN
Cj4gPj4gb2YgbmV3IHZpcnRpbyBsZXZlbCByZWdpc3Rlcj8NCj4gPj4gRG8geW91IG1lYW4gdGhl
IHN5c3RlbSBQTSByZWdpc3Rlcj8NCj4gPiBObywgdGhlIGRldmljZSdzIFBNIHJlZ2lzdGVyIGF0
IHRyYW5zcG9ydCBsZXZlbC4NCj4gSSB0cmllZCB0byBmaW5kIHRoaXMgcmVnaXN0ZXIocGNpIGxl
dmVsIG9yIHZpcnRpbyBwY2kgbGV2ZWwgb3IgdmlydGlvIGRyaXZlciBsZXZlbCksIGJ1dCBJDQo+
IGRpZG4ndCBmaW5kIGl0IGluIExpbnV4IGtlcm5lbCBvciBRZW11IGNvZGVzLg0KPiBNYXkgSSBr
bm93IHdoaWNoIHJlZ2lzdGVyIHlvdSBhcmUgcmVmZXJyaW5nIHRvIHNwZWNpZmljYWxseT8gT3Ig
d2hpY2ggUE0gc3RhdGUNCj4gYml0IHlvdSBtZW50aW9uZWQgYmVsb3c/DQo+IA0KUENJIHNwZWMn
cyBQQ0kgUG93ZXIgTWFuYWdlbWVudCBDYXBhYmlsaXR5IFN0cnVjdHVyZSBpbiBzZWN0aW9uIDcu
NS4yLg0KPiA+DQo+ID4+IEkgdGhpbmsgaXQgaXMgdW5yZWFzb25hYmxlIHRvIGxldCB2aXJ0aW8t
IGRldmljZSBsaXN0ZW4gdGhlIFBNIHN0YXRlDQo+ID4+IG9mIEd1ZXN0IHN5c3RlbS4NCj4gPiBH
dWVzdCBkcml2ZXIgcGVyZm9ybXMgYW55IHdvcmsgb24gdGhlIGd1ZXN0IHN5c3RlbXMgUE0gY2Fs
bGJhY2sgZXZlbnRzIGluDQo+IHRoZSB2aXJ0aW8gZHJpdmVyLg0KPiBJIGRpZG4ndCBmaW5kIGFu
eSBQTSBzdGF0ZSBjYWxsYmFjayBpbiB0aGUgdmlydGlvIGRyaXZlci4NCj4gDQpUaGVyZSBhcmUg
dmlydGlvX3N1c3BlbmQgYW5kIHZpcnRpb19yZXN1bWUgaW4gY2FzZSBvZiBMaW51eC4NCg0KPiA+
DQo+ID4+IEl0J3MgbW9yZSBzdWl0YWJsZSB0aGF0IGVhY2ggZGV2aWNlDQo+ID4+IGdldHMgbm90
aWZpY2F0aW9ucyBmcm9tIGRyaXZlciwgYW5kIHRoZW4gZG8gcHJlc2VydmluZyByZXNvdXJjZXMg
b3BlcmF0aW9uLg0KPiA+IEkgYWdyZWUgdGhhdCBlYWNoIGRldmljZSBnZXRzIHRoZSBub3RpZmlj
YXRpb24gZnJvbSBkcml2ZXIuDQo+ID4gVGhlIHF1ZXN0aW9uIGlzLCBzaG91bGQgaXQgYmUgdmly
dGlvIGRyaXZlciwgb3IgZXhpc3RpbmcgcGNpIGRyaXZlciB3aGljaA0KPiB0cmFuc2l0aW9ucyB0
aGUgc3RhdGUgZnJvbSBkMC0+ZDMgYW5kIGQzLT5kMCBpcyBlbm91Z2guDQo+IEl0IHNlZW1zIHRo
ZXJlIGlzbid0IGV4aXN0aW5nIHBjaSBkcml2ZXIgdG8gdHJhbnNpdGlvbnMgZDAgb3IgZDMgc3Rh
dGUuIENvdWxkIHlvdQ0KPiBwbGVhc2UgdGVsbCBtZSB3aGljaCBvbmUgaXQgaXMgc3BlY2lmaWNh
bGx5PyBJIGFtIHZlcnkgd2lsbGluZyB0byBnaXZlIGEgdHJ5Lg0KPiANClZpcnRpby1wY2kgbW9k
ZXJuIGRyaXZlciBvZiBMaW51eCBzaG91bGQgYmUgYWJsZSB0by4NCg0KPiA+IENhbiB5b3UgcGxl
YXNlIGNoZWNrIHRoYXQ/DQo+ID4NCj4gPj4+PiAtLS0gYS90cmFuc3BvcnQtcGNpLnRleA0KPiA+
Pj4+ICsrKyBiL3RyYW5zcG9ydC1wY2kudGV4DQo+ID4+Pj4gQEAgLTMyNSw2ICszMjUsNyBAQCBc
c3Vic3Vic2VjdGlvbntDb21tb24gY29uZmlndXJhdGlvbiBzdHJ1Y3R1cmUNCj4gPj4+PiBsYXlv
dXR9XGxhYmVse3NlYzpWaXJ0aW8gVHJhbnNwb3J0DQo+ID4+Pj4gICAgICAgICAgLyogQWJvdXQg
dGhlIGFkbWluaXN0cmF0aW9uIHZpcnRxdWV1ZS4gKi8NCj4gPj4+PiAgICAgICAgICBsZTE2IGFk
bWluX3F1ZXVlX2luZGV4OyAgICAgICAgIC8qIHJlYWQtb25seSBmb3IgZHJpdmVyICovDQo+ID4+
Pj4gICAgICAgICAgbGUxNiBhZG1pbl9xdWV1ZV9udW07ICAgICAgICAgLyogcmVhZC1vbmx5IGZv
ciBkcml2ZXIgKi8NCj4gPj4+PiArICAgICAgICBsZTE2IHByZXNlcnZlX3Jlc291cmNlczsgICAg
ICAgIC8qIHJlYWQtd3JpdGUgKi8NCj4gPj4+IFByZXNlcnZpbmcgdGhlc2UgcmVzb3VyY2VzIGlu
IHRoZSBkZXZpY2UgaW1wbGVtZW50YXRpb24gdGFrZXMgZmluaXRlDQo+ID4+PiBhbW91bnQNCj4g
Pj4gb2YgdGltZS4NCj4gPj4+IFBvc3NpYmx5IG1vcmUgdGhhbiA0MG5zZWMgKHRpbWUgb2YgUENJ
ZSB3cml0ZSBUTFApLg0KPiA+Pj4gSGVuY2UgdGhpcyByZWdpc3RlciBtdXN0IGJlIGEgcG9sbGlu
ZyByZWdpc3RlciB0byBpbmRpY2F0ZSB0aGF0DQo+ID4+IHByZXNlcnZhdGlvbl9kb25lLg0KPiA+
Pj4gVGhpcyB3aWxsIHRlbGwgdGhlIGd1ZXN0IHdoZW4gdGhlIHByZXNlcnZhdGlvbiBpcyBkb25l
LCBhbmQgd2hlbg0KPiA+Pj4gcmVzdG9yYXRpb24gaXMNCj4gPj4gZG9uZSwgc28gdGhhdCBpdCBj
YW4gcmVzdW1lIHVwcGVyIGxheWVycy4NCj4gPj4+DQo+ID4+PiBQbGVhc2UgcmVmZXIgdG8gcXVl
dWVfcmVzZXQgZGVmaW5pdGlvbiB0byBsZWFybiBtb3JlIGFib3V0IHN1Y2gNCj4gPj4+IHJlZ2lz
dGVyDQo+ID4+IGRlZmluaXRpb24uDQo+ID4+IFRoYW5rcywgSSB3aWxsIHJlZmVyIHRvICJxdWV1
ZV9yZXNldCIuIFNvLCBJIG5lZWQgdGhyZWUgdmFsdWVzLA0KPiA+PiBkcml2ZXIgd3JpdGUgMSB0
byBsZXQgZGV2aWNlIGRvIHByZXNlcnZpbmcgcmVzb3VyY2VzLCBkcml2ZXIgd3JpdGUgMg0KPiA+
PiB0byBsZXQgZGV2aWNlIGRvIHJlc3RvcmluZyByZXNvdXJjZXMsIGRldmljZSB3cml0ZSAwIHRv
IHRlbGwgZHJpdmVyDQo+ID4+IHRoYXQgcHJlc2VydmluZyBvciByZXN0b3JpbmcgZG9uZSwgYW0g
SSByaWdodD8NCj4gPj4NCj4gPiBSaWdodC4NCj4gPg0KPiA+IEFuZCBpZiB0aGUgZXhpc3Rpbmcg
cGNpZSBwbSBzdGF0ZSBiaXRzIGNhbiBkbywgd2UgY2FuIGxldmVyYWdlIHRoYXQuDQo+ID4gSWYg
aXQgY2Fubm90IGJlIHVzZWQsIGxldHMgYWRkIHRoYXQgcmVhc29uaW5nIGluIHRoZSBjb21taXQg
bG9nIHRvIGRlc2NyaWJlIHRoaXMNCj4gcmVnaXN0ZXIuDQo+ID4NCj4gPj4+DQo+ID4+PiBMZXRz
IHBsZWFzZSBtYWtlIHN1cmUgdGhhdCBQQ0llIFBNIGxldmVsIHJlZ2lzdGVycyBhcmUNCj4gPj4+
IHN1ZmZpY2llbnQvbm90LXN1ZmZpY2llbnQNCj4gPj4gdG8gZGVjaWRlIHRoZSBhZGRpdGlvbiBv
ZiB0aGlzIHJlZ2lzdGVyLg0KPiA+PiBCdXQgaWYgdGhlIGRldmljZSBpcyBub3QgYSBQQ0llIGRl
dmljZSwgaXQgZG9lc24ndCBoYXZlIFBNDQo+ID4+IGNhcGFiaWxpdHksIHRoZW4gdGhpcyB3aWxs
IG5vdCB3b3JrLiBBY3R1YWxseSBpbiBteSBsb2NhbA0KPiA+PiBlbnZpcm9ubWVudCwgcGNpX2lz
X2V4cHJlc3MoKSByZXR1cm4gZmFsc2UgaW4gUWVtdSwgdGhleSBhcmUgbm90IFBDSWUNCj4gZGV2
aWNlLg0KPiA+IEl0IGlzIHJlYXNvbmFibGUgdG8gYXNrIHRvIHBsdWcgaW4gYXMgUENJZSBkZXZp
Y2UgaW4gMjAyMyB0byBnZXQgbmV3DQo+ID4gZnVuY3Rpb25hbGl0eSB0aGF0IHRvbyB5b3UgbWVu
dGlvbmVkIGEgZ3B1IGRldmljZS4g8J+Yig0KPiA+IFdoaWNoIGRvZXMgbm90IGhhdmUgdmVyeSBs
b25nIGhpc3Rvcnkgb2YgYW55IGJhY2t3YXJkIGNvbXBhdGliaWxpdHkuDQo+IERvIHlvdSBzdWdn
ZXN0IG1lIHRvIGFkZCBQTSBjYXBhYmlsaXR5IGZvciB2aXJ0aW8tZ3B1IG9yIGNoYW5nZSB2aXJ0
aW8tZ3B1IHRvIGENCj4gUENJZSBkZXZpY2U/DQo+IA0KUENJIFBvd2VyIE1hbmFnZW1lbnQgQ2Fw
YWJpbGl0eSBTdHJ1Y3R1cmUgZG9lcyBub3Qgc2VlbSB0byBiZSBsaW1pdGVkIHRvIFBDSWUuDQoN
Cg==

