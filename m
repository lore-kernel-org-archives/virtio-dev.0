Return-Path: <virtio-dev-return-13154-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1359DEB64DC
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 16:59:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6A0CD1CA247
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 16:59:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 641D5986703
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 16:59:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 57DE1986639; Thu, 29 Jun 2023 16:59:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 429469865D8;
	Thu, 29 Jun 2023 16:59:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TowYGSll7dnlkqc7GLluf+4yxVV7QoV6KfCEiwneD7LI1iPAmgvWm6O3jGZZ8d+0EU5ZXboIL5mY58pgr9A+C7owRssoxa30F92oUSXyusoV414ue327pFchVZwYV/lIUymekrp3rtUpw8L+7FlpvX+bEafDMzLLAFYz0KHDT6vSGiS86zPvra9d/ntGjmbBN9AzBEgAOS5xNep6RZgl4Cw4sZ1G0fCZwLitsGfvzjHQJr/hvlVY47rAKEDkvg3bH9rVXDMyjCMyFnNM4pIZFS6Qk382R8uSQB/SVbgIroUoF3Dhe8EQAgwHV/obxj0HfFm8bllx6TRhQNF9XOThGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzqQDpZCjCDfX1qoTGe/YRSEetvRH1etaVFh00zzltE=;
 b=F67LTNpcyaypMcLhOLRRjVzA3+EJwtQzWQFpNukKJvi/yBuAhpO/u0nnc6RvBsQLDVOyFWbllQh+S/WENa374DitApecy9aAnreuTWY5uivoFwDpJCk3L5QqFaANwCAacE2ZzXHA73pabPg0VTF7aoZGxWiBX/QemLP6Ds3glBHfjBBvkhZ7F/TvA8WyXLJdGZB9rjpbKL22CP21bRdfl54v3NLwQg2vP+aOFSB+ADs7wm8M0RN0FPci8dSKyi3oHRb14uIvY/D3s5yp8aea9qmgzj/iCVyBFAb2vthiZHOamArprDeIrOo9El5c03HztkLp9js411Dsk7H0cyKQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Yuri Benditovich
	<yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] RE: [PATCH v19] virtio-net: support inner
 header hash
Thread-Index:
 AQHZqRVyfixvgxNlsUC5ASNdYCAGYa+flAoAgAAIhiCAAGduAIAAXkuggAALg4CAAAFYEIAACUwAgAACI2CAACUrgIAAZinggAAEMICAAKLeAIAAVsQQ
Date: Thu, 29 Jun 2023 16:59:28 +0000
Message-ID:
 <PH0PR12MB548127F715FC8B9FB14B5614DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628061257-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481ED6C94DE8CC414C3369BDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628123131-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BA1CDA0942170186CB59DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628132122-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814D42786A6981467D3FADDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628152125-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EAD97F6163C52DF4FF53DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4132affe-9b97-a81f-ad57-50ed4341678b@linux.alibaba.com>
 <20230629074627-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230629074627-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7023:EE_
x-ms-office365-filtering-correlation-id: f3e9c31b-d05e-4938-04e3-08db78c233b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tR01K+S71kb2n11TQK3WzLmz/yGdamCfkSG91s3FfCZr8R7pUCkUAsLjhRqGtO/SifOwDB873A5Jwx+9YmM7LUdk31iyt3cRrq6o3dMtrSBvmojz2AUlvcUwhAvbFux0zMVo5Pop6LeRaeIitaqeMalBEDo7sp7uQO/m3Yt/9CmHqXczTyi5zXO4gSTQNcCwVwUvDWQAwOuu76eDFMIfO6uuGJdPOGszt7rYRc+rtG4ZB90cZrtMb1lv21MvRk0WPFD4C85oQKAkYEmYWVVQ93BzC1lNlyZkgqH4wXJsv9dzCpJ9yAINdghj2dyE7+aD/qqxqkZHYBVHCIV+n+9Smtf+/LTZZhTDY80su0y2RJNCAwOKlLBfwNcbOEs8Cv1mDCt9uQFsRja3VfxFJUquqfZpqmFOsf9Tv0VspxU4DlV8jUZPe7a4rfPuctmalPEQiDC2ZfNemPpMqr2PaHpbvbxOs2Qs/5vSWb5g5pMAcSKGp+yweHDA+HD8kwEszLDpsLZu4ETHL7x7WGvsg3CGDtUCsiG5KOwPXJnq/kgHikihNxsCKYU9/cMVGeTKJSF+K4qxI8c2VhGWNtbCcUneP/4T5OAUXllNy1wZw6rHx1Flgn14daB+5B61u4Bgnarr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(66476007)(4326008)(66556008)(38070700005)(478600001)(6506007)(7696005)(110136005)(71200400001)(54906003)(26005)(186003)(4744005)(9686003)(2906002)(122000001)(66946007)(5660300002)(52536014)(8676002)(55016003)(76116006)(38100700002)(64756008)(86362001)(33656002)(41300700001)(8936002)(316002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eEx0VjYzNXZJcC9iMWFzOW5KV0RjZEZ3cUJvNXpJSlJ0T0dCV2dkZkFiSXJ0?=
 =?utf-8?B?dHpLRmxIYnl3RUI1U2EvSXoxd3BxckJNL2pmL0c3dUZQWkdBQS9HblVVNEZS?=
 =?utf-8?B?ZUNzdkwrVGZlQ3lCV1E2eC83akkwVzk1S24wZWQ2OVRrbVJFaVNqQUxnOFFJ?=
 =?utf-8?B?SkNtaHF2WU8vdFFBK3UvSGE2Wkd5UnNPUWpLVEhyQUhzTkFpdU9BY2Y5Z3Mw?=
 =?utf-8?B?NnlHU1Fjek53MjBVem04VzBSWWx5aXp1aDJ3QnFsRGtnOUN0QXRhSmRZZEIr?=
 =?utf-8?B?YjNkQ21ndGtCWlpWUjNZcEMvTjIxTXUvbHpnN0VZYk50clZmSFdBdnc4c3ZZ?=
 =?utf-8?B?UnlrUG9vQkx1YUdDWkYyWU44M2QvbkVGbXIvVUtUQ2RBVUVxb3hoWTNhTnA2?=
 =?utf-8?B?T3pzUDNDRnM0Z1RTQmhqbDM3SXVwSTRPaHJHbnA0VTcvOHgwL2ljREsrSlFw?=
 =?utf-8?B?MUZKL1Q2SzlqRVhtQklOYkxGL2s2ZFV6SHY2N2NGZWwwSVl4MHFNWmUwVHow?=
 =?utf-8?B?cXh0SURZZEpGYVZjYjJRTTYvN0FiWmgrNmgwZitEQXRUTStvbS9CcTdpb1lj?=
 =?utf-8?B?REFhNFBGKzVkNEVXSTZoaDV2aEpueG44dHRDK1pXUW1jZmVQNWl1ZTYrZnFH?=
 =?utf-8?B?ZlBCelJoZVoxMEF4emhGbXNjS2JlTGs1NE1XajZPdHA4WHc3WUZxdGVYTUQr?=
 =?utf-8?B?UUJBNUpGa1VsRDluMXlVWEE5RlY0Z3o4MGtpOC96VjZBdTFURzlDRzhnWUUx?=
 =?utf-8?B?K2pKNlE1YS9LRGhMOTQ2dU9YaDVXWC9yWjlRMjhHWUh1cGJ5Y0dLWGNLZXpp?=
 =?utf-8?B?TWxsRnk3UWs3dGdKcGx5dHI4NkxleW5YbDFBQTJNT1NieElXWjNDQStrZDlm?=
 =?utf-8?B?eTd4Y3hqYzB2VFdIRVFKZjRSU3dBRWZCZG1Hdzl0clEybGVtcmNITnIzaEV3?=
 =?utf-8?B?UytXUE92TlV0cTVEYjdlZkRHUzZrOG1VajhjS1NYYThPcXFlRzQyWkQzcXNW?=
 =?utf-8?B?Wi92a0JkTm9aM05Na0g5aUJOV2hiMENpbGtoV2ptNjhma1M5RElvK2pZdE0v?=
 =?utf-8?B?Z3pXMUFEOXJqKzhaNE9GT2dVdkZON2JBSy9vVHVldnpBbHlHTGxuTmF4TlBY?=
 =?utf-8?B?dVo0aFN3aWw4ZVU2RldwbFMvUVg1cFRCOUUzVHdDaklRMTBJTGtIMHExZ2JM?=
 =?utf-8?B?SmlOTnNXR0xudExNRXEvTGlZNU5yWWgzOXBuYzAxbURpV3lIbk5MMklZcDFx?=
 =?utf-8?B?bTNJTnlGV0NkVVRZby84Wm9Ga29lYlhlbm9sK1RjcHR6Mm53TENUTTFqcVhC?=
 =?utf-8?B?WkxPUXhqczZWdXJSZkdhdWdlQktNQmZRZTlZUU92QWhhbFdtdThscDlUdE41?=
 =?utf-8?B?Zi9oekNuR1BCaUVkQU9Bclh2b253TVg5aHMvTXZCbzVhMHl2czYzM0c4eDQr?=
 =?utf-8?B?V1V2MWQ3b0tzc1lVRmFCa1gzZXpkK29uaGR4OXlsYzNDUytaeDZNWEZPZElN?=
 =?utf-8?B?VllnVm9zSVEvM21rMzB6clJkdmtUOU43NnhyOVExRGtTWVhGZlNIaXduMVFD?=
 =?utf-8?B?NHgwTUMyeUI0ZTJsejd3NU5QQ2VnWWFlbmxqT3kzWXd4WlphaW8wYlFKVXhq?=
 =?utf-8?B?QXkvRm1VTFo4M0kzY1dtT0pvTnlDRUNNSENRVEx1NDZST0pObXczY21Hclpv?=
 =?utf-8?B?aThEbGVPd3ZHZXRIaTN6OFRFSHFpU1hLTzluWEg0aU9LR3ErK013NFM4eHhw?=
 =?utf-8?B?SWtBUnhpN3dqcXN2WVI0dlBWSDU0TjRseWw5blBxaWM5Q0pLZkxmVTNvc0NT?=
 =?utf-8?B?VWtYS2k5N0VuWDRSd0ZMMWljY3BZWFNNNUNPeVp4L1FiUXJTOXl6RWd1ZkRN?=
 =?utf-8?B?ZGNySGFnRE44WkM5Y3dyQWMwMitkMmF3ZWZOME9vZGM1aVI0cEFUenRCZXg2?=
 =?utf-8?B?cnVRbDFQT3IrRHZUc0lnbmF3bVR3dDdwSUgxa3grbHdYZy91UU9NcDAxTDhN?=
 =?utf-8?B?N0E5NXpFOUN4a0lOclVOelBQYkpiY0FpVURPWEtIdk9YajQrdUhHS2YzQStx?=
 =?utf-8?B?Q2ZPL0NkQUE2NHY1Ymp4SmY0Ukp5SThqMGQvT1AzSzF1Z3ZaQ296TU9CZXkx?=
 =?utf-8?Q?i3ZI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e9c31b-d05e-4938-04e3-08db78c233b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 16:59:28.9218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eY4oOJpCCjKFc9r79k+OXbakYyLBYU64qrSFuLBkhadHUXMSpISG1hYRZX8MqxnSBJFb/So9np6qwvl7txXTzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v19] virtio-net: support inner header
 hash

DQoNCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDog
VGh1cnNkYXksIEp1bmUgMjksIDIwMjMgNzo0OCBBTQ0KDQoNCj4gPiA+IHN0cnVjdCB2aXJ0aW9f
bmV0X2hhc2hfY29uZmlnIHJlc2VydmVkIGlzIGZpbmUuDQo+ID4NCj4gPiArMS4NCj4gPg0KPiA+
IElubmVyIGhlYWRlciBoYXNoIGlzIG9ydGhvZ29uYWwgdG8gUlNTLCBhbmQgaXQncyBmaW5lIHRv
IGhhdmUgaXRzIG93bg0KPiA+IHN0cnVjdHVyZSBhbmQgY29tbWFuZHMuDQo+ID4gVGhlcmUgaXMg
bm8gbmVlZCB0byBzZW5kIGFkZGl0aW9uYWwgUlNTIGZpZWxkcyB3aGVuIHdlIGNvbmZpZ3VyZSBp
bm5lcg0KPiA+IGhlYWRlciBoYXNoLg0KPiA+DQo+ID4gVGhhbmtzLg0KPiANCj4gTm90IFJTUywg
aGFzaCBjYWxjdWxhdGlvbnMuIEl0J3Mgbm90IGNyaXRpY2FsLCBidXQgSSBub3RlIHRoYXQgcHJh
Y3RpY2FsbHkgeW91IHNhaWQNCj4geW91IHdpbGwgZW5hYmxlIHRoaXMgd2l0aCBzeW1tZXRyaWMg
aGFzaCBzbyBpdCBtYWtlcyBzZW5zZSB0byBtZSB0byBzZW5kIHRoaXMgaW4NCj4gdGhlIHNhbWUg
Y29tbWFuZCB3aXRoIHRoZSBrZXkuDQo+IA0KDQpJbiB0aGUgdjE5LCB3ZSBoYXZlLA0KDQorXGl0
ZW1bVklSVElPX05FVF9GX0hBU0hfVFVOTkVMXSBSZXF1aXJlcyBWSVJUSU9fTkVUX0ZfQ1RSTF9W
USBhbG9uZyB3aXRoIFZJUlRJT19ORVRfRl9SU1Mgb3IgVklSVElPX05FVF9GX0hBU0hfUkVQT1JU
Lg0KDQpTbyBpdCBpcyBkb25lIGFsb25nIHdpdGggcnNzLCBzbyBpbiBzYW1lIHN0cnVjdCBhcyBy
c3MgY29uZmlnIGlzIGZpbmUuDQo=

