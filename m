Return-Path: <virtio-dev-return-13220-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA12EB64DA
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 22:15:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1E28F29FC9
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 22:15:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1335A986811
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 22:15:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 03C0698670E; Tue,  4 Jul 2023 22:15:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E1B2E986637;
	Tue,  4 Jul 2023 22:15:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uyou4vc1SZ6tYS6UUsYG7jnwWx4k+5hFJ4Y6ovf3tQJwdSVafWIctMvfADMbz1zRqQ17PLKaWXVAqTKeclZJn5Ufg6f8XJJbNbUjYGIiOPK4QixQDHL8A2Ip2a4FdzDsXLzORfj5D4VpL4HXeqvHH4rgbK/e84dMdn0DiqxGUtMFXyJrIjPhEvSZ0agvZPyCmdN/26jvvekDtF8rEceNnfzlPWd03/oBJj3YFmiGG2GI4evwVPcQIHukSKi/+MvKvSvjwo1TzMotk5+xeBMuhni1ExZ5tsJl2zs6K26Q/1XQFMBPoqubwJSL28i5vJxb4ORjTWYT/se7INPRohuhfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGJvoWkjzm9v4bUbq9AxtQDAa33OIlllTw/rgPTBJcM=;
 b=ekGOGOTW7Cu8zDTDfK2N7diZwJWpazX7qCdlDE9XtIT+vSry79apxjFPKC4pWNxWo6pWdwWiTujSDGvGg1c6Dhx2cah0pK4Wd1XMFI0iZ5+wKYh9pFsIL9kRsA8yzIDegsEuOEgMhcieVD5OOD34Dg1BAkeoV7ge5Ohmw8j7QCUM3fzAqkno4rUh/VE1op0XSrLSqvfXO2kJJ/fXgeda/NuG7UfVAo7oM/MdtFGzKnW/OeuR7BBXIPcIvYY4y2ZdJTwEbVcoD5qAcanbn8+RNEybC2hKmtizkQNc7N6de15kt5nKGvOWeBRQGgD1x0muJHmK0fytVnpzLkt76yb9Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v8 3/4] admin: Add group member legacy register access
 commands
Thread-Index: AQHZqwo9gupu6w0ua0ue/guTiCilX6+qL9oAgAACxqA=
Date: Tue, 4 Jul 2023 22:15:34 +0000
Message-ID:
 <PH0PR12MB54817F7888F3FAA6F8874055DC2EA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230630042006.1569920-1-parav@nvidia.com>
 <20230630042006.1569920-4-parav@nvidia.com>
 <20230704171700-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230704171700-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7936:EE_
x-ms-office365-filtering-correlation-id: aeb04501-4bcc-4ba9-8c63-08db7cdc300c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 N8T57ke6q2iyF3ytvBrNhVRFhmYypEQpRuPAzpmpe2TfZ93L0WsodQno/CfOiE0ylqTEbMb8IqDsGq73tpuhFAqEqnKG3RcIe1OGYDq4di8IGogKKByMIDi2kUmCvo8ZsZfHPpe1iWWupgih73RIUCVipk3q8Bw+hGcQZwrsIplMxXng5Mu527TpFMrsRmvyRYC276rBNctore580YKBhvdqw7YxnjMuG+FjOJSs1WvKtI+vpy08cDtm+NQfXqH5hojW9FH25FIJrBdaD4+XeO6wCVsQW00opuyyxZ2R2d7iVyfq8rPetmRXTpeI9j7WPlAiTC8FT1NOjXKry35lYvuC+zCO+4DLqz+OLiY8c+uqwsYBczrR2Pi9Szh/Cu9qXwJ0J7ZZGLqOz3nJQ6qLWja/yDA1rWls1/eQN9LNfpzScM8AUN+gu3VhnSDaDZ2cf+b6//pAlqkcQa9bKdlk1AqWF/FmE1aBaY60IRW2Oye4JAMmScHEDQqgoJElzn7B/CyCWzOOk/SRWINaRjmxIWZW/l1qM5xZmw1r5qIe3kzCdLqMFGfbparo7AXmynum/1dir1SngQYcy3O85oT7Fmj8R78as539Glth8UJrl/H9OFVApglBGXwawXm3B7Ti
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199021)(41300700001)(86362001)(38100700002)(7696005)(4744005)(107886003)(71200400001)(83380400001)(122000001)(186003)(6506007)(26005)(9686003)(55016003)(54906003)(38070700005)(478600001)(316002)(66476007)(6916009)(4326008)(76116006)(66446008)(66556008)(66946007)(8936002)(64756008)(33656002)(8676002)(52536014)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHArUmgwMmQwdzc2cE5QcVA1WDBONmdCZ2FxZ0UyYnJQOTlMQ2ZLNEEyTSt1?=
 =?utf-8?B?ZGo1ZFowc3ArNGFZZDZaVVhJUlN6QTFQVHRSdi90QnFlbTdtRjFVQzFyWHQ4?=
 =?utf-8?B?Sk9zUHNsQ29YbFAwN3I4UCtrTE9GVVRhOWY3QnkzZ1FybjNUSEdFMXhjU3Nw?=
 =?utf-8?B?MklQb2JKUVZoTG9Dd2UzQm8rZTBrcnZjWDMrL2VibmhNbTFvUDVRYWtpR1o5?=
 =?utf-8?B?Ni9Sa29pRVN1Z054ZHMzTzNEMnduemYxUHpZK1VrTXlrbUtEcGxtVXorZGxM?=
 =?utf-8?B?RjYzeDc3OFpkS1ZieW9ja1FVejdURVc0c1IzV1ZCczZqWUIwTThONFVveG1t?=
 =?utf-8?B?cGo0bHdXTmU1MzV3Nk5WVCtPakdzckVSc2lLcWdad2MwNmxTVTk2SE5pODgz?=
 =?utf-8?B?WHVyeDJSR2svSkxTYUcrSXlyakZYMmI4NFhQTW5WanhhR2ZFZ2M5c0crMmVu?=
 =?utf-8?B?YUZyWGJUQlJkMjhuUFB0NlhoL2k3dk1pZGRuS0JRcVlmUWxpWWdReUx4bE54?=
 =?utf-8?B?aGNHWTVOdk1yZUdpK2RZQjFrYlpBbXRsWHh6YXpHdEc0clA1M2xBVEh3R0Y5?=
 =?utf-8?B?R0F1ZUNoNkxNU0l2OVVaQ0gwckducUVVWTg1RHRKSnk2c3dkQzhvRkF6aGJ4?=
 =?utf-8?B?UkV5dllUbjJOU1p6ckkvY2xZeTBvUm1uSTFNSWVaMXNCeG5iVFVGRjQyNTV5?=
 =?utf-8?B?WXJBR3RDUjAramFnRmhQVHV3cmhrc0lsa21xc2RhaXE3cVQwaHA4Y09mTEt4?=
 =?utf-8?B?T0p2SXNILzJrNVgzNWdQa25SWnpzNXJzRGp0ZXpYVVZCVW1RUzRZdHRmdFVV?=
 =?utf-8?B?VG4zeHJEbXJPRzlNQ3ZpTTFic3BST0htMWw1S3cyVGo3Ylc0Q0tML1pDVVF6?=
 =?utf-8?B?eTlia3lCb0lHcWV5LzdCZWhMWTM2NGNJMUhzTXJlMnZkY2hLRkhFK2hjZWlF?=
 =?utf-8?B?bmVLNm5zdTAxVHIzcTRYa0xpYVFBdTZvQlpERWlkNEhGMFpaVWZoWmc4M0s1?=
 =?utf-8?B?czhmZWNZeXhtOVAyWWhLY1VybEdLWWtPeVUxQU04YkZYMTBPN3pqdjZuM2R2?=
 =?utf-8?B?a3dILytrTWlUZWtETHNJVjdqOFd4QUNiM1VmOUxpRmxqNitwOGRCcTlqTENS?=
 =?utf-8?B?Skk2NE1lbFBUcXhzeUdlcXY4UmNhYk9wUU94OHBOZHBxYTFHd0ZLRGlyWjlS?=
 =?utf-8?B?clEvTDJsN0RwcGJqdDZScGVBQm5RZ0VYQnROMXhVMVNJWUVVRHIxOWp6R2dE?=
 =?utf-8?B?K0Mrb1djbXNCT2ZvNnFJNEdXcVVkOWFvVDRQOCtwU3Uvb0x1V0ltdXQ4NnBM?=
 =?utf-8?B?NGN0SkNWSFlMV3U0emk1cURqYmtaVjdQYklCQjdKekk2ekJMeHljcE9xN0Q3?=
 =?utf-8?B?eG1PQUs5VjIvTEdFUTdFUlltTlRUc2tROVRrVXpoRUxlMlF3T1dRNzF4Q1hO?=
 =?utf-8?B?YWN6QnBySjZuNkVTcHZkbS9acHpPZXE2d0dzYzI0SkVOM0tDMndBSCtBT1NI?=
 =?utf-8?B?ZzBqdGQzeHN5dy84UHhBMm1ZQnZRdlVBYXR2UTloL3RDQ1I2UDlKbklGNklE?=
 =?utf-8?B?R3YrdkQ5eGU2SHoyTVoxdW5zdjNNSHpBbjhTY2dVbFp4dkJCdjJCV0FTblRY?=
 =?utf-8?B?S3hmY1pEa3Mrcy9CYkE3RXdkU3ZNVFErN2ZmaGpLTmhheGkrVmxxR2gyN2E2?=
 =?utf-8?B?S2ZwaFJieGc2VFlieEgzMkpnaHpEdnhUK0xFZFUyWmt3cldYT0xIbHNLb3FL?=
 =?utf-8?B?emd3RW9PY3c0MXRZZFNWYjZIZnBDRkVRdUdaMjd4MHlBTnJZZ2NpOERNTXh2?=
 =?utf-8?B?L1JkL2RmNmhKa245enUwYUpsQThtTWZjWFRoWTZ0bGxPSHA0UWNzOGFkYkNr?=
 =?utf-8?B?d0FzMUxkS2p3MTMyNUtma2hlV3cxTVp6OVArYWN2Rm1VYysyQ1paSktwQW44?=
 =?utf-8?B?aVR1ZnIyaDZQb1lWRlBNM2FueUJDaWJSVDloUUpYbHUvUUtzUzQ4eWNVRVZj?=
 =?utf-8?B?TktQcFhiTWljc0RBKytoNkhsRXRHKzdHcVpMV3FlU016MmhnTmdjQXdTdjRB?=
 =?utf-8?B?aWRXdGxKdVFYWWN1OE5Pc2xFMENKYTNqMDFiQ09JNEhzWTVhajE3SHZQSXFQ?=
 =?utf-8?Q?QyFc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb04501-4bcc-4ba9-8c63-08db7cdc300c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 22:15:34.3502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n6PlNzraeULAHcL12G1RQGRptjomamj7KoNrq8D3Vgz/77fi+uWPKmLoeXL2X4nv8nF99Ozm/IJkZL1Kut2IAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936
Subject: [virtio-dev] RE: [PATCH v8 3/4] admin: Add group member legacy register access
 commands

PiBGcm9tOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBKdWx5IDQsIDIwMjMgNjowMSBQTQ0KPiANCj4gSW4gc29tZSBzeXN0ZW1zLCB0aGVyZSdz
IG5lZWQgdG8gc3VwcG9ydCB1dGlsaXppbmcgbGVnYWN5IGRyaXZlcnMgd2l0aCBkZXZpY2VzDQo+
IHRoYXQgZG8gbm90IGRpcmVjdGx5IHN1cHBvcnQgdGhlIGxlZ2FjeSBpbnRlcmZhY2UuDQo+IElu
IHN1Y2ggc2NlbmFyaW9zLCBhbiBvd25lciBkZXZpY2Ugb2YgYSBncm91cCBjYW4gcHJvdmlkZSB0
aGUgbGVnYWN5IGludGVyZmFjZQ0KPiBmdW5jdGlvbmFsaXR5IGZvciBncm91cCBtZW1iZXJzLg0K
PiBUaGUgZHJpdmVyIG9mIGFuIG93bmVyIGRldmljZSBjYW4gdGhlbiBhY2Nlc3MgdGhlIGxlZ2Fj
eSBpbnRlcmZhY2Ugb2YgYSBtZW1iZXINCj4gZGV2aWNlIG9uIGJlaGFsZiBvZiB0aGUgbGVnYWN5
IG1lbWJlciBkZXZpY2UgZHJpdmVyLg0KPg0KSW4gdGhlIGxhc3QgbGluZSwgSSB3aWxsIGNoYW5n
ZSBmcm9tICdsZWdhY3kgbWVtYmVyIGRldmljZSBkcml2ZXInIHRvIGp1c3QgJ21lbWJlciBkZXZp
Y2UgZHJpdmVyJy4NCg0KSSB3aWxsIGZpeCByZXN0IG9mIHRoZSBjb21tZW50cyBpbmNsdWRpbmcg
aGF2aW5nIHBhZCBieXRlcyBhZnRlciBvZmZzZXQgYW5kIGhhdmUgc2ltaWxhciBjaGFuZ2VzIGlu
IHJlc3Qgb2YgdGhlIHBsYWNlcy4NCg==

