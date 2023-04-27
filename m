Return-Path: <virtio-dev-return-12443-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9FBC77B60
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 00:11:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B415B2CAF3
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 00:11:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A4B0B986653
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 00:11:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 98558986644; Thu, 27 Apr 2023 00:11:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7EE7B986641;
	Thu, 27 Apr 2023 00:11:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOm8dLAAe1RqydaEnenmokCRSj7aCPpmVgfyaK7qZwfPlLUEe3pOU2z97m5KYb9j8ZFk8c1f+laeyoDj/omtTPG8qc9XRSwUIK3LAn0RTh3TKvhmrwNvIif1H3HCu5L+O6mbt0RMD1oKdunzTei9lnMzyHFz8YIMwdvGjsubKjCNaSIPharh4TIAK9RsXg4Pq2UWLLcnCzm69eE36ck+lWatm5qiuZwGCYn0aO6v0Ev3hnHf684OQcwMuJEtiYbiEz03FwWF4YCUTVjIKFJc4jLdHN9Zynze3F6HYGtEtYMOh46n1bYnHUFqpZT94jby22m6bhit7ch6RJbG733tyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lyTqk/c/OkBnW+TwI0arps06mKQU/7UtRCEy29zI98=;
 b=X7p2+XLGzWgKj+Lmt7pti84JJ8DMm2sw1D3TI7Wa43sqYNIsVK4TCcS0uSPdxt9SxiLXIEwQsFxUDbptajzcBQoctorqevE+zyqejbx58hpmZuxQ+WGLo1b7275M2f715H2mLtoovaxfTYgIwcOHERetnQZGa1gklGIPOOoEVc863rxLMVbrtMkC1Q45TZq/jF80ie1EDoopL1Q0DtGD8w/GJaQSmjou1iVuoq7o1s1gtpc9k4n/722p+udpuit3KQwtqG3X3avSEeElwAYvfCXuwZKNO0drh88xhHYZKzkEkwbKjmgz1ZPumSenOdmIR+hpaDG1ozRNGyoN9X3TrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com"
	<hang.yuan@intel.com>
CC: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Jiri Pirko
	<jiri@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v12 05/10] pci: add admin vq registers to virtio over pci
Thread-Index:
 AQHZdswSyG/pcJpYf0OyhtV/kRPNfq87BFIAgAACO4CAAxNugIAADL9ggAAJXoCAABmgsA==
Date: Thu, 27 Apr 2023 00:11:31 +0000
Message-ID:
 <PH0PR12MB54819792ED9279E66B63AC26DC6A9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1682354275.git.mst@redhat.com>
 <8a3435860747eeaa038ece4ff896c1cdd441c185.1682354275.git.mst@redhat.com>
 <5858e2e6-0b50-c155-85e9-eea6dfb533e1@nvidia.com>
 <a4b1596c-2132-714a-7557-fa5249a55945@nvidia.com>
 <5cb79b37-a066-283c-eee7-afd26146d988@nvidia.com>
 <PH0PR12MB5481B60350D145531A43E567DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b7addd39-d913-700f-ac67-1412825d580b@nvidia.com>
In-Reply-To: <b7addd39-d913-700f-ac67-1412825d580b@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB8026:EE_
x-ms-office365-filtering-correlation-id: 7cf50aa6-9de6-4ecd-4cd4-08db46b3f49c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 272iUsd7kjgY3UkNZXnbo0datNArQ7dNn7TQV5+DJVTziRTT/S51llZE+08qUQsKX5JMM+tmcOCIzMxVdc828uF5MR3RU98cvlL1aWVE5gcbsmVDkbejRxqN5csEFI+oypokXZMvXveFiNEH8c1/mV0FABB3Dv0Ys2PysvCWZZCH5NPN9sPRrGMLZg9b1Gdw2KLjfPODqOrAYGS5xiYPsp4hv/EVHDEzmohymvuRJN26y3xgrHqUnSeSCx4iHMpmprxlop24CbOZir8KlhApH6asR3WxQ9AKpm7XjR+FeVROcrFFc1jpwwIAfWtZS6nQC7fa7a6r8gtW6/nc801RMEgj3KIQZ2d14y2p9VHrC5bjPKRiqvR+dKcMA1Gb/XK2DX+4tJ/9UrtcgJAYF7a4Lx+LKMj25qY/BkB9KbbTbq+z6pDxrKya47wW6KF+2XQnLyfw1nW6tIeIPaBDsUidIpjdKdOjmTlQD6pNtYL6hQ604fZOqOpRX3suuG57XMmULNK2K5H4QOLSYcfw66JXVCRLETBIETbe9x2vt/G43k/eV6XynkIwVSmAL3JZkgrFRznb1biwOib+/FHexTEpgd42Gc73B0ZOK0akz0OIo7svzZihJ1YLkIzKaVt+8aRNn8bpuEVrm89LabKTUcpsDTzRf7LKAy89dVSOnNAwZCc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(38070700005)(8676002)(2906002)(8936002)(38100700002)(7416002)(5660300002)(52536014)(33656002)(86362001)(9686003)(55016003)(107886003)(71200400001)(966005)(26005)(6506007)(7696005)(110136005)(83380400001)(478600001)(54906003)(186003)(316002)(66446008)(66556008)(64756008)(76116006)(66476007)(4326008)(921005)(66946007)(41300700001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MDNUeXozL09icmpnK0ZzOXZWNGlDMVduSGdQRXExTmQzUDhyRVkyemcyMU1H?=
 =?utf-8?B?L0RlSkNJOGhKYmF2UjJsLy9LWEhtaWtDcUw3TjRWOHo0TGhyRlF6T2taSWp1?=
 =?utf-8?B?OTB4aXd0NVdSS0drbU40ZVhnVC94UEFhanQzNEVRQnpaRGFFQ0ZtNDVMYWpi?=
 =?utf-8?B?RHFtWktWcWs0cU1qeVc5Ny9PeGoyamExSFJUNTVDL3FTV2tWMitjZGkra2E1?=
 =?utf-8?B?Rm5lU0YzeTVEeVBLTjlOdzk3SVdDSWdRL290RmxRMWZFa09XR1lXUnRmbjlp?=
 =?utf-8?B?Q29IWExPbmEyampCUmcrdTFFM2xBRmVybHd2OXBDYmdkYUFTMEpNdXVtVlRB?=
 =?utf-8?B?L0RlTTJ2eGpZTDhndEpDMVViRWNPdEFZcXZWSVVtY3RCRUhZalAyTE5ZSkty?=
 =?utf-8?B?Z1g5b0NkK2ZNYm5rNlJhbWdQWGN6T2hRZkQ3bER5cXl5UTJJemU4bWdOaXps?=
 =?utf-8?B?SkpPMFkzVmdpNHJ5clVjUFhYdVYwaUZBNC9WYmwvZzFVREQrd2lFWXVvd1pk?=
 =?utf-8?B?dXRtL1NYRlE3NW9ObUw2ZjFWTVhhRkwrOWhjb2IrZmVHdENxOG1xbWN2Q3kr?=
 =?utf-8?B?bGF4WEtwSWt0TU4wNzFOTjdNaC9WS3Z0TWtGRVY2aGV4WGI2QWowMVdEUW9X?=
 =?utf-8?B?QVFDU0FpbDhQaHZ3UkRJTTFPVmc2M3BmK2I1NlRoWk83VWlzSC9oWk81QWVR?=
 =?utf-8?B?QUljbEpwUzVUTncwaDZUdU5kUEk5WCtmLzNwejg1Z0hLbmpkOWR4QUFWcGsr?=
 =?utf-8?B?UmsrUzlMWDlrNEwrUkYxd0s1K3pqRUlQVGtteWNzQ3h1aEh3SlczejBrUlNo?=
 =?utf-8?B?a0JmL3FGVGRuVnMzL1RiUTZMdDhrODRYQWRiQklnQzM5Z1NzTGJITWxjWVhs?=
 =?utf-8?B?bW9wMDFmcnY3RnJ4U2xnekhCT3lKbGhuUTdVdFQ0NFJRUjZ0bk82cnNFNEtY?=
 =?utf-8?B?Z1pKb2p1UEpsa1hvcWdoNTNRZ2VVdzBWOUM4WUpEZjA1UnIwNGY5Rk5rRzc1?=
 =?utf-8?B?Q0t4b3BzYjZ0d1diRWhPbUJkS3Rjdlp3QVFVRWRkbng2TWx3UnNrRnd5Z2dW?=
 =?utf-8?B?MTg0bnVlb0NGZStnS0c3MzlFeW4yNjhSVFNtdC84UDI2Q3k3V3ZUZGlZS1BM?=
 =?utf-8?B?bTBQTWpFUnZQdHp0WjQ3a3hFdnc0bzJOQUFDanJKaVFzSDNKU1RQYS9ZM1JL?=
 =?utf-8?B?YmNxYTB1Tmc5WnovZmpXNlovNDhQU1lTbmdxb0dUV1lHbTkxZ0RvNW1iTG5w?=
 =?utf-8?B?ZGN2aXFVd3E2Q1V1NWlYQzhIUk9oMzVGUUdpdXNsNzFTUk83TzZ4OTUrQUhT?=
 =?utf-8?B?QzZEWGVGZm9DRUpxQ1pJaUlOVFdFRmVmQWNZU3FaSjhqY2tyZGtuSGVOSW5i?=
 =?utf-8?B?eGprMThreUMyd0oxTGdYR0xGdVE3TTlGL01yb3AyMVVwcVRMVms5NGJoS3lW?=
 =?utf-8?B?RVdNbWZRV0dWK3oxWVl5Y0d5ZVVlZzNwZWZCUjlaYU56cW1mRjNwakNJblpF?=
 =?utf-8?B?ZzlVWlNPdjRLZWozRGQ1RTEyenFDNXZ4a01FU0pyUFpWaytzQXJBbHIzb3Ri?=
 =?utf-8?B?TFdkWlc1SkR5Y29uQS9ZTk9uUzdsU1MzYWR3ZThUM3RJWEE2VXZFY0d5eDJm?=
 =?utf-8?B?cU9XR0xaUnc4emdMVEptR1M3VEFTT29VODRYZ3hDcHBUcUdZTzk3K21OR00v?=
 =?utf-8?B?OFllVCtHb3VWOU1Xbi9rellNRHQ4QmZVOHVyU3JzZU8vOCtNN0E3aFlHVVFY?=
 =?utf-8?B?MDdxTW9uMnVjYUxBc2FVOTh6S21YZHQxbUp0b1B6RGUxU0pQblZqQjZZa3RC?=
 =?utf-8?B?TGx2MUd3cFBHZmZ1QUlaUkViK1l3K28xdUdXT0NoeklVaDYzb1pHOGNLcEda?=
 =?utf-8?B?VWNmd3oyOG1iQzlTdE5pZHdLOFlBeXZhRWIwRHpld0h3ZnNmUlJwM1ZQTWE4?=
 =?utf-8?B?a0Z1aG9PVTUyQjFDeGFvVnFLby9aQTcrZlYrNmd0dzRmdmp3TDdoQkh4azBw?=
 =?utf-8?B?OEtwaG93NzlUOE5RSlJQaTRVWGNVWEpaVC91dUlQdnZCeDFzaHNkeFk0QWZM?=
 =?utf-8?B?YXlCQ3NST0owYUM1THBnbEVxNUFPU0duc3ZXM3pSOE1ONDBibkkyajQ4V0RZ?=
 =?utf-8?Q?D5gw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf50aa6-9de6-4ecd-4cd4-08db46b3f49c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 00:11:31.9584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: md0hK9nEusAXiZgcz02Q5XcBWmwKsJjT/ma2ifYuNOQLeKPab2Tb/55iz6MiRLMBbChL2wkbAmR6YJ2ZUkWwWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026
Subject: [virtio-dev] RE: [PATCH v12 05/10] pci: add admin vq registers to virtio over pci

DQo+IEZyb206IE1heCBHdXJ0b3ZveSA8bWd1cnRvdm95QG52aWRpYS5jb20+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgQXByaWwgMjYsIDIwMjMgNjozMSBQTQ0KPiA+Pj4NCj4gPj4+Pj4gK0lmIFZJUlRJ
T19GX0FETUlOX1ZRIGhhcyBiZWVuIG5lZ290aWF0ZWQsIGFuZCBpZiB0aGUgZHJpdmVyDQo+ID4+
Pj4+ICtjb25maWd1cmVzIGFueSBhZG1pbmlzdHJhdGlvbiB2aXJ0cXVldWVzLCB0aGUgZHJpdmVy
IE1VU1QNCj4gPj4+Pj4gK2NvbmZpZ3VyZSB0aGUgYWRtaW5pc3RyYXRpb24gdmlydHF1ZXVlcyB1
c2luZyB0aGUgaW5kZXggaW4gdGhlDQo+ID4+Pj4+ICtyYW5nZSBcZmllbGR7YWRtaW5fcXVldWVf
aW5kZXh9IHRvIFxmaWVsZHthZG1pbl9xdWV1ZV9pbmRleH0gKw0KPiA+Pj4+PiArXGZpZWxke2Fk
bWluX3F1ZXVlX251bX0gLSAxIGluY2x1c2l2ZS4NCj4gPj4+Pj4gK1RoZSBkcml2ZXIgTUFZIGNv
bmZpZ3VyZSBsZXNzIGFkbWluaXN0cmF0aW9uIHZpcnRxdWV1ZXMgdGhhbg0KPiA+Pj4+PiArc3Vw
cG9ydGVkIGJ5IHRoZSBkZXZpY2UuDQo+ID4+Pj4NCj4gPj4+PiB3ZSBuZWVkIHRvIHNheSBzb21l
dGhpbmcgYWJvdXQgb3RoZXIgdmlydHEncyBpbmRleGVzLg0KPiA+Pj4+IEZvciBleGFtcGxlLCBp
ZiBhcSBpbmRleCA9IDAgdGhlbiBmb3IgdGhlIHZibGsgZGV2aWNlIHRoZSByZXF1ZXN0DQo+ID4+
Pj4gcXVldWVzIHdvdWxkIHN0YXJ0IGZyb20gaW5kZXggPSAxLg0KPiA+Pj4+DQo+ID4+Pj4gY2Fu
IHdlIGFkZHJlc3MgdGhpcyA/DQo+ID4+Pg0KPiA+Pj4gSXQgbWF5IHNsaWdodGx5IGNvbXBsaWNh
dGUgdGhlIGRldmljZSBpbXBsZW1lbnRhdGlvbiB3aGVuIGRldmljZQ0KPiA+Pj4gZHluYW1pY2Fs
bHkgY2hhbmdlcyB0aGUgVlEgaW5kaWNlcyBiYXNlZCBvbiB0aGUgbmVnb3RpYXRpb24gb2YgdGhl
DQo+ID4+PiBmZWF0dXJlIGJpdC4NCj4gPj4+IEFsc28gdGhlIGRyaXZlcnMgd2l0aCBhbmQgd2l0
aG91dCBuZWVkIGEgZGlmZmVyZW50IFZRIGluZGV4IGhhbmRsaW5nLg0KPiA+Pj4NCj4gPj4+IEkg
YW0gdGhpbmtpbmcgdGhhdCBhcSBpbmRleCBzaG91bGQgbm90IG92ZXJsYXAgd2l0aCB0aGUgdnEg
aW5kZXggaW4NCj4gPj4+IHJhbmdlIGV4cG9zZWQgYnkgbnVtX3F1ZXVlcyBmaWVsZC4NCj4gPj4+
DQo+ID4+PiBUaGlzIGFsc28gYWxpZ25zIHRvIHRoZSBleGNsdXNpb24gb2YgYXEgY291bnQgZnJv
bSBudW1fcXVldWVzIGZpZWxkLg0KPiA+Pg0KPiA+PiBUaGUgbmFtZXNwYWNlIG9mIHRoZSBhcSBh
bmQgb3RoZXIgdnEgaW5kZXggaXMgdGhlIHNhbWUuDQo+ID4+IEFuZCB0aGUgY29uZmlndXJhdGlv
biBpcyBkb25lIHVzaW5nIHRoZSBzYW1lIHF1ZXVlX3NlbGVjdCBhbmQgb3RoZXINCj4gcmVnaXN0
ZXJzLg0KPiA+PiBUaHVzLCB3ZSBuZWVkIHRvIGFkZHJlc3MgdGhlIGFib3ZlIGNvbW1lbnQgb3Ro
ZXJ3aXNlIGFsbCB0aGUgZGV2aWNlDQo+ID4+IHZpcnRxdWV1ZXMgY2hhcHRlcnMgYXJlIHdyb25n
Lg0KPiA+DQo+ID4gTWljaGFlbCBoYXMgYWRkZWQgYmVsb3cgbGluZSBpbiB0aGlzIHBhdGNoIGlu
IG51bV9xdWV1ZXMgZGVzY3JpcHRpb24gc28gaXQNCj4gY292ZXJzIHRoZSBleGNsdXNpb24gcGFy
dC4NCj4gPg0KPiA+ICsgICAgICAgIFRoaXMgZXhjbHVkZXMgYWRtaW5pc3RyYXRpb24gdmlydHF1
ZXVlcyBpZiBhbnkgYXJlIHN1cHBvcnRlZC4NCj4gPg0KPiANCj4gVGhpcyBpcyBub3QgcmVsYXRl
ZCB0byB3aGF0IEkgd2FzIHRhbGtpbmcgYWJvdXQuDQo+IA0KPiBGb3IgZXhhbXBsZSBpZiB2bmV0
IGRldmljZToNCj4gDQo+IDAgcmVjZWl2ZXExDQo+IDEgdHJhbnNtaXRxMQ0KPiAuLi4NCj4gMihO
LTEpIHJlY2VpdmVxTg0KPiAyKE4tMSkrMSB0cmFuc21pdHFODQo+IDJOIGNvbnRyb2xxDQo+IE49
MSBpZiBuZWl0aGVyIFZJUlRJT19ORVRfRl9NUSBub3IgVklSVElPX05FVF9GX1JTUyBhcmUgbmVn
b3RpYXRlZCwNCj4gb3RoZXJ3aXNlIE4gaXMgc2V0IGJ5IG1heF8tIHZpcnRxdWV1ZV9wYWlycy4N
Cj4gY29udHJvbHEgb25seSBleGlzdHMgaWYgVklSVElPX05FVF9GX0NUUkxfVlEgc2V0DQo+IA0K
PiBhbmQgaW4gdmZzIGRldmljZToNCj4gDQo+IDAgaGlwcmlvDQo+IDEuLi5uIHJlcXVlc3QgcXVl
dWVzDQo+IA0KPiBTbyBpZiBvbmUgZGV2aWNlIHdpbGwgZXhwb3NlIGFkbWlucSB0aGF0IHdpbGwg
YmUgd2l0aCBpbmRleCAwIHRoZSBhYm92ZSBpcyB3cm9uZw0KPiBkZXNjcmlwdGlvbi4NCj4gDQo+
IEFncmVlIHRoYXQgdGhpcyBzaG91bGQgYmUgYWRkcmVzc2VkID8NCg0KT2ggeWVzLCBJIGFncmVl
Lg0KSW4gcmVzcG9uc2UgWzFdIEkgYWNrZWQgaXQgYXMsDQoNCiJJIGFtIHRoaW5raW5nIHRoYXQg
YXEgaW5kZXggc2hvdWxkIG5vdCBvdmVybGFwIHdpdGggdGhlIHZxIGluZGV4IGluIHJhbmdlIGV4
cG9zZWQgYnkgbnVtX3F1ZXVlcyBmaWVsZC4iDQoNClNvLCBhZG1pbl9xdWV1ZV9pbmRleCBkZXNj
cmlwdGlvbiBuZWVkcyB0byBoYXZlIGRlc2NyaXB0aW9uIGxpa2UgYmVsb3cuDQoNCmFkbWluX3F1
ZXVlX2luZGV4IG11c3QgYmUgZ3JlYXRlciB0aGFuIG9yIGVxdWFsIHRvIHRoZSB2YWx1ZSBvZiBu
dW1fcXVldWVzLg0KDQpZZXM/DQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy92aXJ0aW8t
ZGV2L2E0YjE1OTZjLTIxMzItNzE0YS03NTU3LWZhNTI0OWE1NTk0NUBudmlkaWEuY29tLw0K

