Return-Path: <virtio-dev-return-13740-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFF5CA0ED1
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:39:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C60EF2B00F
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:39:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BEC6D98663F
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:39:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B362298612D; Wed, 13 Sep 2023 04:39:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2455986630;
	Wed, 13 Sep 2023 04:39:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgk9CtfWxMHi94yZjNVSEfgvj/i9zDYuVsDfQmFjqFuJQ9tKGHRJcGE9PEdQZ5Ef4L2H6JPtkyX+uer4A8fUkg7cwch6BJfMG3zp9qFxHmc/WRNBsgJV5raTpGejVBo3HrdUxYFwmvkM1jEM7SKhuGu98jwhjX//spDPsuSQnHQbHs0ICg9YOZ1sQZ1/jTeV/dv6WYloq5mN+Dv4lb12r+eFGxAOpNLyTnt25P11LnTnhTCI6KhwripIB7XAWIHxmLPx7q5Q09ZNqmvkrUEUSKEVLjA8mm/7Wj/R+BN1SXHgFmRGwcf+qtSa2OCqQyDomk45AnXVtRFgY/+Xpz751g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/NTYhkXVOvPoMiAPvzTHUAHSJ0TECVDvs9uivWU6+w=;
 b=Kk2IB/EmhKhZ9S2sxjATYoGURg9i2PRKBbEyqPnHklCXla5hrksmRdgvu49SiWBMZtymKd3joJpwpxdSNYrsr18ZMm6zltTBPw579Py85HlrEymBAUilyixRUggZ48D+PMpc3NrUPbMeTNueOqaCeg1yUEKVcKsIuM2wqVCDjYifI+TIloelZGd4bGTZPDDbu1g93VRbOkwGpKexQ+XZ+eIKRKs0ETxaRq8TMX3O9VA37i+kU2v1TXDRZo4GdZmAKi0GM0gNlX75BGBffoeRLCZe160cc1cNxfs1uSgaMi4hVETWK+/BEfsJC1zuMuti3RIO/akvMCHlGgQIf90ELw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAFrJICAAB38cIAACoIAgAAB5TCAAAzeAIAAAVowgAAud4CAAABSIIAAAeaAgAABfOCAACmSgIAABu0AgAD11YCAAAB9wIAAAcMAgAAElCA=
Date: Wed, 13 Sep 2023 04:39:34 +0000
Message-ID:
 <PH0PR12MB5481ABA7D65B7C9A51506E8EDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <CACGkMEt9ATuU_OwtE_9rF1XHKCd9GavWCHx6_dFXCZibMKzJjA@mail.gmail.com>
 <PH0PR12MB5481D538B4F3F76B393C5757DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7cc22be6-f984-ba53-5979-0306a118a6df@intel.com>
 <PH0PR12MB5481961B5EA6DEE900CCF068DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5449424a-4872-0164-0c3f-caa34ad46388@intel.com>
 <PH0PR12MB5481CBCF7BEE5637D16BC179DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4c4c2478-c90b-fb5b-cc06-bc74293862b9@intel.com>
 <PH0PR12MB54817178B8D5799FE74D4331DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <85b1670b-5094-cdb8-fde9-1a9c0906f094@intel.com>
 <PH0PR12MB54815711322F1CAC35189CEDDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b0ae1197-f9e9-4596-f9bf-559f6112458f@intel.com>
 <PH0PR12MB5481E0C8D74DD3479331E0ACDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7abce4d9-4762-dcad-6fdf-068588ebb3d9@intel.com>
 <PH0PR12MB54817F7ED583FA9A03735CBCDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5cc89852-72b7-b79b-10e5-7fd62a921fe4@intel.com>
In-Reply-To: <5cc89852-72b7-b79b-10e5-7fd62a921fe4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7105:EE_
x-ms-office365-filtering-correlation-id: 8aac657e-1220-476d-bc89-08dbb4136dc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /Gies72pVedyuluMSehFKLoo9LBYfyEpUMj/uW4yIIk2YWkdpg8MsHsyfLjGHghJeNzNqXggBm1lOUImOPeIQbLcQ6tPirgNsKH6KPwCcMzuPJECoX34Y/9KYXKfon5qYriTEe5kCCswR0X9IK5FHXFSRTSwgbS1I+RQP81PRULWyj5Q4MHNnbo1zdHheYVGXYOcf6lmv5Eo6Xo70W99rroV3vvJTRpdihcc3LQWyB8m9dmsyt1pW0UJlNv+u0lfhZ9UiE1EpeMBUZsa99+P6y8LxyAR4ak19ARdU0ug/w4JxXePVXJKJjHhvOdDuUTdbP91D827Ts9BknuoIW/A/tIlyhNOXwas7400aC9wF3KRZNUxVIxSr0mx2I4IMH+kURERE7ZpPnWRWcqsWVITo3eDry3FYnJxlGMTYvnij5Dn4n+KmPmWO8MFP67aj8EKnkb3JC8XAitHGoaXRhzmmSCkO6pca6DB1kGzUCyuOyLoVB9bBTw0gLdzxlSQmOqFnMBlauEWQCs6l1C3o0PYdm1GdY97i+tffpm7eb89VnP5KnHI8Mg/WEQfAet4rsmOu1eJgw3UhJjHNZ5K2d/izV+EuHKhTN15rxSjlhKPdXuEL8ujlGRTczox+ssRO53h
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199024)(186009)(1800799009)(122000001)(71200400001)(478600001)(86362001)(83380400001)(6506007)(64756008)(7696005)(26005)(33656002)(9686003)(110136005)(55016003)(8676002)(76116006)(54906003)(4326008)(8936002)(66476007)(316002)(52536014)(66556008)(66946007)(5660300002)(4744005)(38070700005)(2906002)(66446008)(38100700002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUR2TG9JNWU4VGdsdlAxUU80c2tsZUJPa1dIdTIvQ2lHN3VxR2szbzZ5TEpo?=
 =?utf-8?B?dnpuclJTU0VTLzlkc2pRb3lvQlEvN25aNVIrQU5WZk0xTDIxS2s0R05PSmpK?=
 =?utf-8?B?bm9qWFJkTC9jOWxPS2pxV1RYU0hzclhDb3pQZHR4QTVYUTNVNDM0TjcxanZG?=
 =?utf-8?B?RWxtQjJWUHc3V3lWbHlaWHZ0Wkp0UWE1aWF5TmJsNzdDU2dMeEYyOWczdHJm?=
 =?utf-8?B?Zjhxc1ZZZDFjY0hQSmVOOFFZVUllbnBMdThjdnFIUkMyUW5MYWlIaUhiZ1gy?=
 =?utf-8?B?aUExV1lUV0tnaWxaUkZuMTRDM3hmam9NTjZ5RVd2aklBWTdOOVFHMHlLUGNR?=
 =?utf-8?B?KzIvdjg0OWg0ZDNMdis2azVHTHZZTllNQzNxVXdvQnpiRUIxWGd0aUFDM0lI?=
 =?utf-8?B?WldwenJJNC9vWXozN3pSYWM0UUhBc1g3NFZaeHJmTVcyNzJoazN6OXFqbWN5?=
 =?utf-8?B?b3BWWGQycFFkcjNVK1FBM2lHUitoQytSOGVCUE8zNzFDNWNUdHpHYVcyK1VR?=
 =?utf-8?B?SDRSTkZ4VjVYYVA3eS84SEVoVnBNSFJ3SDhzb0NpZ2hLeTNmZWZaWFM5U3c3?=
 =?utf-8?B?KzdTTUJ4RVppd3k1OXRYRytBelVMd1c2UUdtNUh3NkpPYXNUMStyOUVLa09m?=
 =?utf-8?B?d1pUTUIwY2xybHpzTTM1aGErZ1FZSFdFcFJhNnQvcHlPRGEwL2RVZ01pWWw1?=
 =?utf-8?B?cGN1UnhBU2Z5c0UwaDVnclVLYlNQMU96U0JlRU44bU5GRGlUUmhkU095QVE0?=
 =?utf-8?B?VE5oZWN6RGw2M0NjaVd5OThRTlFNRWdoY1JTaWxYMCtNUTk0OFArSVdPMmd2?=
 =?utf-8?B?VmlJYzd0cFc3YzdjWGJ0SW5XR29ORjkwZzhHRzFtbUxHRVdUZENqa1hTZzBj?=
 =?utf-8?B?UmpQYkovQXNpekUvYWE3ZjZHeGhFN3JnRTM0Q0tVQ0gvZ21VZmVlNXVKRFBL?=
 =?utf-8?B?WXdnRFVrRW9EY0VzNExEKy82ZGcvTWp2UDZhckQrK3lqS3BQNnZLeW15bWFx?=
 =?utf-8?B?MlAzOHdkSXduMldlaWNlRW51Q1MzL0dVSU5FTkVveG5hQzhkTXIra2ZIeG02?=
 =?utf-8?B?azQ1SzhrbkpLNkJYSWszMkdZV0cyeWo5WEdVRUpMSW1nWXA4M3NIWXhiZGNE?=
 =?utf-8?B?TXQvaEQrOFZjMjNuR3cyLzJQL1NpcWhDbUsweDdYSytZbElwQldYVGd3L2pO?=
 =?utf-8?B?cGRmVHpTdnV2THg2ZlFneDd2VGhjZkpGdXBrK0VhNGdpUmtHQUJDcE9HN3ZK?=
 =?utf-8?B?UnNPRTluRHZYMHhOM2Z6bGRYcTN3dytrdE1aV0hQb2lPTDUvZFFVVHd0ZzJr?=
 =?utf-8?B?VEdBOGs1dXdxU3NVeFhNZDJBQTJaQmIyd1N3RVY3Q0pFa2JtVXAybS92Tm9j?=
 =?utf-8?B?S2JhTFZ2LzBIbFlxRHAwbGFWRlhzMnE3ejdBRWFVaHMweHZmWFpPdjF3VjJY?=
 =?utf-8?B?QVd2OVJCUXhvcXF1eFEvRGMvYkl2ck41VE1kMnFiMDRNNW44WHVGamJsQjJx?=
 =?utf-8?B?MktjeU8yTms2T3FGcGk1SEREZnFjMWExRjcwQXRtV1lUTTBiRXRWeUhJTlRV?=
 =?utf-8?B?T3dHQ2hxblNTNTdLdnBURVZ2K3pON2dLMXZxeHk1cTNhYTJTeGNkNzFEb0lC?=
 =?utf-8?B?anZWa1Z0Nk5JN1kvcTlXN2ppQ0JpeVhtY1cvN3lpU05xRGpvNHllYWJlN1l5?=
 =?utf-8?B?R0ZhZnYxM0I5dDZtYlVTVHRUUW1mUVlXV3I5TDN4eDNiczZ0OUhSWGVNVHVi?=
 =?utf-8?B?Z084Sk9SeGt3VThUWEtZSEF5cGVYeFhPeHpubjNvbE9TRDl5dXpLYmNzeXEx?=
 =?utf-8?B?Nm1YMTNMVmZ5a3JPakdMc0t2SmNZMVlRbld2eTExNktHNFVpSnlRT1U3MFdq?=
 =?utf-8?B?UGk1RlhoMitTU2o0RDJqT2VZY2RBbjhDQjg3dW4rRlZnQ1B1ZkVRRXlJK0Fl?=
 =?utf-8?B?aXl2WVY3bnArWDBZWE9FaG1jSVJ6Y0xqY0hEdkhVaTl3WGZCN1ByY1dvNlJI?=
 =?utf-8?B?MjFGc0VreTdua1FEQjBXNmJWSSt3ZzJta2VFMHV3TGdYQUV6TmE1Q1VvZTVI?=
 =?utf-8?B?MWZqaUdSbjRmYnNWMm53b1dDbFl6cG13T0pPa3lEYTNqN0JNVDNtMFhmZjJw?=
 =?utf-8?Q?YtEc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aac657e-1220-476d-bc89-08dbb4136dc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 04:39:34.1956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwKGB5B1NQtqDsdfKVHgrHJ6l4KwxqW6jXMZBObsKPK8oikTvJbSLvLJIKbiZMFa8tVp4Qti2TNE526OGGrhlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgU2VwdGVtYmVyIDEzLCAyMDIzIDk6NTIgQU0NCg0KPiA+IEl0IHNob3VsZCBi
ZSBuYW1lZCBhcyBTVVNQRU5EX0NGR19TUEFDRS4hDQo+ID4gQWxsIG9mIHRoaXMgZnJhbmtseSBz
ZWVtcyBpbnRydXNpdmUgZW5vdWdoIGFzIE1pY2hhZWwgcG9pbnRlZCBvdXQuDQo+ID4gR29vZCBs
dWNrLg0KPiBpdCBhbHNvIFNVU1BFTkQgdGhlIGRhdGEtcGF0aA0KT2sgc28gaXQgd29ya3MgbGlr
ZSBTdXNwZW5kIG9mIEVuZ2xpc2ggZGljdGlvbmFyeSwgdGhlbiBhZnRlciB0aGF0IGFueSBvdGhl
ciBWUSByZWxhdGVkIGNvbW1hbmRzIGRvbuKAmXQgcHJvZ3Jlc3MuDQpCZWNhdXNlIGl0IGlzIHN1
c3BlbmRlZC4NCg==

