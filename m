Return-Path: <virtio-dev-return-13488-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267F0EB64DD
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 03:16:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7649760355
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 03:16:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 65F27986499
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 03:16:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 58866983EB3; Tue,  8 Aug 2023 03:16:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 47383986460;
	Tue,  8 Aug 2023 03:16:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NihrdYR553ERIcONymeB5lAI9bkiIeBW6oWnwkaoFdCUFgvPQ7s+rezlSL50eyxOvWsz+ggfykXQA6jac280ROExzUj77sdNqmJBB3SQZz2vKipVo3xl50rcFhbauIbGgi705tq6A+KuZ9Tj1MmJ/BQ/otO87e4iesHWb7y4qN59zqVKrSGsG/jrJfbiUKby4mtw9D1edtzgurJKA2mdLG5KfBzl7dYBDJnZ5pCHLo+XG2ki+iZDs0Y6L9mM+t4SMTx0doXoHDhJs6X3QpOAOPSOKFKwdg9o5UfxW3gm0vGQVWgF18PO/7XyrCiC2QZiCvgrlI8NHEqdAFzAEMnVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fc2+7dUbQN+g2GP8MJhg/rt/LVO3HPaDINt6udhFmY=;
 b=mN1TDyKrNDFn5YgWGgH0VKxJHlED6p10XpsDjzWBhtSXyWaRrNaL/XO038kirn/RWoaDtAI9lrNMBwYicFDpRHAPVtzhAiDZKi7CP8ksiOahPoIWxsGUPQs5Oias4zc6Vn4h+gtvkKXFeu5SyZkJrKfBpylWLnJE6J6+DZzW8YNdfqaM1kK9TtnRZTBTYOX6dSkFjkz1aUkgL5HoGgRrasdOEvzKFF7zAZrmOcu+9ktuQ2ad2u1cb1cQbf+WaTf/OkeaJ3mzJ10ku6IbwCewhJJZ0ZpBxLFkeErOaNrHTxWvynUycAxaYCNm7+KGqQHQduPq0XYB3EG0hbn5mPPB5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: RE: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC]
 virtio-net: support access and control the member devices
Thread-Index:
 AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YUmCAgAAS74CAAAGPkIAAAc8AgAACoHCAAAFdAIAAAN7QgAACXwCAAAH+cIAAASWAgAAY2vCAAR9QAIAAAoAAgAAHcYCAAAfd0IAABlWAgAAvCwCAACGFIIAESeeAgAFTlICAAAUXAIAACRuAgAABk3A=
Date: Tue, 8 Aug 2023 03:16:44 +0000
Message-ID:
 <PH0PR12MB5481D3BDFB943D7856D846A9DC0DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org>
 <1691059929.235804-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B5B3C5366CCACB221083DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060652.3764465-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548191AE225B08BACFC0C350DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691061508.9066079-5-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481CB7BE555F4672394A6ECDC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062204.2378864-7-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481E104793F9E68E1DC95CADC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062877.0013635-8-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691129914.3255427-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481F521F146049E5E483B7DDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691132049.7182267-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481BE16AC810CD3A6D64832DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691135097.4908528-3-xuanzhuo@linux.alibaba.com>
 <20230804053958-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548152A5677F0508A62587AFDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691388171.3192031-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtKcmvBqSJac4aNQMtvE+fYnOeLxeeXz1vtP5d2PM69bQ@mail.gmail.com>
 <1691462188.324996-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEszg7nUNH2bW+EQLVxnPvUzT66D8=V8x7JKw+DL=RzsiQ@mail.gmail.com>
In-Reply-To:
 <CACGkMEszg7nUNH2bW+EQLVxnPvUzT66D8=V8x7JKw+DL=RzsiQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA0PR12MB8208:EE_
x-ms-office365-filtering-correlation-id: c8895742-07a0-4eb8-b3a7-08db97bde511
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ej9Dr/A3GTmwDZOVWWyX6pzICvxZ6N6vwNdw8C6XzP3rvvkOI8L5vIOS7UngG7lMH2LOP63QawVdp7fgRQbdrzlToU244k5X77TGwZKR4slZ2BsnAlAt6JSrczgdzpR0qyTu4QuKpH3lDFI87F+YrHIPpL23YM8NkOLv2n2qwWihVjpGfNEjpVSAaBC+PPNqkIQcg3T6kEOqpkUn2lWzyF4f2ygmdJ7rJ2o5qIuQ+9G4V+xyhJz2FQ9sflaffUn7nNI4cGi3Lm3FbpsQGsbsW2GyLTGdMZRUyVZi/rKg9qW6RyPYGIbH8VrT4nLg1wpe+OmE/Mvt7IcnQBgoALdkf5D3WLsXVvSg8MBS63j3DUEJaHoxeCOrjk68LJymwUExvvyEoZn2C1nGOkGnQoAN+1oKJwxbazuiD5mElflNnhd5jKATtXJo57snFTGGf2XAkVKvDy/Vca306Dwzd/tFsNrY8COVmbhQ8xMVou9vjG1orVUkgPqvn30lOcOquzHi0ZSatvnJv+xToxSQb4pEM/h5TuJ4Ehn4yRWnqeqdikDwxFy7JjIrg8YSMq0NpHWHoRm78Zcu7HehAZmetx+xqrlk4OVXZlCPWtoyzNzeFnOJtjf/k8d3sdssqEYGrZvQQ2o1JZDM/Vez7+1QFCtYtOVcDpLjxe3Asz4tDWuKgjIkhNrKQ4ZNOInHsKwK8wOI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(90011799007)(451199021)(90021799007)(186006)(1800799003)(38070700005)(8676002)(8936002)(52536014)(5660300002)(4326008)(41300700001)(316002)(55016003)(86362001)(4744005)(2906002)(9686003)(71200400001)(7696005)(6506007)(26005)(66946007)(64756008)(66446008)(66476007)(66556008)(76116006)(122000001)(478600001)(110136005)(54906003)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEpISmFZTG1yeEJzcGZoZmJJNWJwTkkrTlgxOFYyb3VMWFllbUtXbEpKOGxG?=
 =?utf-8?B?b09UZngrd3Vrc1Y3bHVyU0xTb04xM3p3OHoxM3cveEd0cFExdjNSclpXcWQx?=
 =?utf-8?B?Y2VDaC9qcW1kT2pGSlI2YUl0alNLNGJWdkRVNFJhcFhleGhOSXRLV2I1M0la?=
 =?utf-8?B?cnVlZVJqOHFoS1J1UzQ5MlZMTldvTnl4VFRFUzkzRzRoL2Qxc2hER0UzbFho?=
 =?utf-8?B?M1hIOTdOUHZ2SHJWMlN1VjE1Y1pMRHVrdFNTZzc4cHVyUHVvZit4cmJRb0R1?=
 =?utf-8?B?ZmdoOVNUc25ySGxneitZeUhDRW5KYkMzZ2Vrd3pPMDRkQ3dyOGtmazJDZmdT?=
 =?utf-8?B?S1BoR0ZibCtIMERzY2grZjVNZUtLS011Z2t2ZHRUZHVvZWwrRXpjNWU5QTFN?=
 =?utf-8?B?Qy9hRjFnNWgxTVEwUEVsaVJvcTBJemozdEszVk5aNE9LUHlrMDhRaWN0Vzd1?=
 =?utf-8?B?Z3JwNk91NVpXVkRzZWEyaU5LOUJ0WUp4bTNnTFBaeFJESUNQdzVyLzQzU3lk?=
 =?utf-8?B?SGxMK3RmNk5MOGR2QTMya0NwVnZ3MlVqUktiOUpVZFdDc0hkZi8vZEUzcjNZ?=
 =?utf-8?B?VzJVcVQxN05CSk16dStFT3dSMVBCR0lCdEdJUzNhZkcwd3hDdlBJVXN5ZWU2?=
 =?utf-8?B?RXljNmhoOHltSmpoTllkRFVEQUttaWRhZkttZHpGVWNpczl4VHFYUHpYSzdB?=
 =?utf-8?B?Q1dqOTZZdnUyQjJsNlZpR1VGdEw1eWlEOW0yTHpXTFdpR0FhUHZqMUg0SjhG?=
 =?utf-8?B?OTE0Q2lNditMNE5vNkFIR2ZlWjdQYmlsUnh0K0t4OTErSTBTNXQwVWJKQnZj?=
 =?utf-8?B?ZUE1NVNqbGJWZ0RGd1krUUErS3VBeGFGc2ZXU1I0Z2hJSUFyQVJLaUUvVGdV?=
 =?utf-8?B?NSt3S2VCaTY2RnlxQ1E1eitVRkJRS1Exd3p1eXJZeS9jSDNielRFWklBRVV6?=
 =?utf-8?B?TzQyZlpub1Y0UTBkNjFQVzlQNVl1YkZkd25GT0FvdEs5UGwrY0ZFS203YXFX?=
 =?utf-8?B?Q1FCbTBPZ0JsNWJaZnJ5eFhoOENQSWFaa1hKMnNrNU9Mak5uYTRtUkRWVWFR?=
 =?utf-8?B?aEtCcDlUdTh2M21TSmE2N3U4TmlibFF5bTdqR0tKbVRHT0I5QmErSjJzSXpP?=
 =?utf-8?B?VWJoaU9KYVplS0tHbGtra0IwUjNZWjJPZWdjWHZlekJyS3ZPNEhCZ2pWVFZ4?=
 =?utf-8?B?UjcxbU50OWxNMUpHaUR3Um96ekpDTVloNytvaDFORlluMkVieWsxSGdGOWJG?=
 =?utf-8?B?SS9XZ2lxNCs5YUZ2c0FXZldXVEdzbktOMXI3KzM0Tlk3bzVweFg2b0o5anJK?=
 =?utf-8?B?Q0NRSWU5Z1JCRm10dVlFSmlUbTdEVmlPZDBmcjhkTWQxeml0ZkhsbWRuZmtQ?=
 =?utf-8?B?QktydTN0a0xCRWd1QkJwT1RjWGpGYkZadGxvTk43NGNZcVNuNWRpMFBIYkJQ?=
 =?utf-8?B?WFhITFUyZmgvMlJ0dm5uL2Ewa2s0eUprMitQR2NGQnFHQ3NuekpZcEtCdmNq?=
 =?utf-8?B?bzFXVW96Z1g5SzVYQ2QrVDlWaTJrcUxjVnUxMnlGc1F5Q3lxQzhjZXJnZ3J0?=
 =?utf-8?B?RldJcGZLcXBXaTZ6Z3NEK3VGSEM1UlkrOXRYRVVaVHFXWmxkeTlMVlM0M3hm?=
 =?utf-8?B?RWEyc0dlQytxOFRXZ0c3bE1DczEyd2VoaEdzWVZlY0x3b0JxZDZzdjJVR3RD?=
 =?utf-8?B?SHRkNXZaWG5UamRxeEMrMENGeS95ZllYUFRWVDBVYXpLckk5bCtOUCs1dmJW?=
 =?utf-8?B?bHZNNzgwdWRxTlZOUEhjMmZWcTNwQWNaRGlyRVhsTHA4UTBaWlpMYkFjekRj?=
 =?utf-8?B?M3RuZmhmdXU0MHNYakUvSkFXR2EzVnJjUUVRN3pzYjhnUDBYOFQxL1VabERE?=
 =?utf-8?B?OThteFNOcjhCa29IMzFWVkVaSThQUWd5cDM3YWhOZ0hZMEJUeG4xb2pHSy9M?=
 =?utf-8?B?RDIrb2loV0xxMmI4eGhva1dGajNaUXBYMFBVYVF4WWNJZno2eE1OaldsbVd3?=
 =?utf-8?B?dm1GdzZpaWY2Q1RVcEZCSkpvcEJRbWpacmV2WS9tYXdXWldtWlhpaEZPSzAr?=
 =?utf-8?B?K2JzU0lXV2o2L2xjZ3Bsc3o4SWRqWFdmbi8ybU56MDhJcHdOK0NKNEtnWFNM?=
 =?utf-8?Q?ZCuo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8895742-07a0-4eb8-b3a7-08db97bde511
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 03:16:45.0284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d224R4sTi7hVWlWjUZjof48LudSNWT9KqoCMowKcg0q4TuiVgDmF0fsgF2wYlIkwsOG9RpWJ9L+ys2TSWInseA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
Subject: [virtio-dev] RE: RE: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC]
 virtio-net: support access and control the member devices

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVl
c2RheSwgQXVndXN0IDgsIDIwMjMgODozOSBBTQ0KDQo+IA0KPiBZZXMsIGJ1dCBldmVuIGZvciBU
WCwgd291bGQgaXQgYmUgYmV0dGVyIHRvIGZpbHRlciB0aGUgSVAgYXMgZWFybHkgYXMgcG9zc2li
bGUgaW4gdGhlDQo+IFRYIHBhdGggb3RoZXIgdGhhbiBkZXBlbmQgb24gdGhlIHN3aXRjaCB0byBk
byB0aGF0Pw0KDQpUaGUgaWRlYSBpcyB0byBpbnRyb2R1Y2UgZmlsdGVycyBvbiB0aGUgbmV3IHZp
cnRpbyBzd2l0Y2ggb2JqZWN0IGZvciB0eCBhbmQgcnggYm90aC4NCkEgdmlydGlvIHN3aXRjaCBv
YmplY3QgY2FuIGJlIHBhcnQgb2YgYSBleGlzdGluZyB2aXJ0aW8gZGV2aWNlIG9yIGEgbmV3IHZp
cnRpbyBkZXZpY2UgdHlwZSBpbiBpdHNlbGYuDQoNClh1YW4sDQpBcyB3ZSBkaXNjdXNzZWQsIHNp
bmNlIHRoZSBvd25lciBkZXZpY2UgcGFja2V0cyBhbHNvIG5lZWRzIHRvIGJlIGZpbHRlcmVkLCBw
b3RlbnRpYWxseSBvdXRzaWRlIG9mIHRoZSBvd25lciBkZXZpY2UgaXRzZWxmLA0KDQpEbyB5b3Ug
c2VlIHRoZSBuZWVkIHRvIGludHJvZHVjZSB2aXJ0aW8gc3dpdGNoIG9iamVjdCBub3csIG9yIGNh
biBpdCB3YWl0Pw0K

