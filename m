Return-Path: <virtio-dev-return-13427-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076D1C04E69
	for <virtio-dev@archiver.kernel.org>; Wed,  2 Aug 2023 03:21:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 476593450
	for <virtio-dev@archiver.kernel.org>; Wed,  2 Aug 2023 03:21:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 381A89865F1
	for <virtio-dev@archiver.kernel.org>; Wed,  2 Aug 2023 03:21:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 299399865F9; Wed,  2 Aug 2023 03:21:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 121EB9865EC;
	Wed,  2 Aug 2023 03:21:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCuKC9xqApYPCuluW5RklpRNv5tNJJ+ezU812vqo0okYhPqF/ZpDCjuN+fMkUIen7wNbqW1VNnmEqwuM+hcoc1ZVhygG0z/uiORZlTkTTIU2tFVPy3fzwZ0dkV3pJUqGdNYuiuU9uWWWcbmpiaYKaLJJexUzF9HT3mrRl+FtGBZMCGBN19PH/SUbX6yIqOL1kJi8GvSCwJMPGEi/T9FCpk5kcoZEy9ng+/3knGqEgFvoI8CUNxJYtggzBvvTLjR4y010t+vzjcy0iDnQjHSziZB49VXxatZF7yOn2UdX3mE+4rIOKbUdgTkkfQrrbJeU3iTF+dbZj8uAc9xs0d8uTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSao7VaK645al3Chl9mICdk1xHKkdouerxmkhIMesmI=;
 b=i4aK5qQv0ql4/dvH+pS3eDG7qKhJ3vwIkkUh+qNBW9oLknM60w3RLRFka4IxQb2Y8aD/DmyKRCAn4p6PCbh9esUMwGijV/AMlsLA6uD/eitgj1Eb4aUJXCRhRCF0goh17whyNEGbGNkPlh/320XnnlUj3RGmCU+T0sbog3FtbHFqnm3ry1ticNWYIr4YTTcUW3dJSNf7hvPD45kwlWnkb6QUxcW5xpPGo8EAu+elGhxVJz6l7eky0NM7EwP4PxkqtZN02nifCPmnMl+1Eyg0BUVT9G7aJPxO0EEFGnGCEH3jDxwhs4rh7iSSPFRQYFfe1xRFHcQUXVi5+1LGUyac/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
	<marcandre.lureau@gmail.com>, Robert Beckett <bob.beckett@collabora.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
CC: Stefano Stabellini <sstabellini@kernel.org>,
	=?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
	<Christian.Koenig@amd.com>, "Hildebrand, Stewart"
	<Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia"
	<Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian"
	<Jiqian.Chen@amd.com>
Thread-Topic: [VIRTIO GPU PATCH v3 0/1] Add new feature flag
 VIRTIO_GPU_F_FREEZE_S3
Thread-Index: AQHZuwRh6691cWFD3EGobeyAVCVbhK/W7j4A
Date: Wed, 2 Aug 2023 03:21:00 +0000
Message-ID:
 <BL1PR12MB5849C19607B02CDA76BD9F61E70BA@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20230720121844.8956-1-Jiqian.Chen@amd.com>
In-Reply-To: <20230720121844.8956-1-Jiqian.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: MN2PR12MB3310.namprd12.prod.outlook.com
 (15.20.6631.013)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|IA1PR12MB8537:EE_
x-ms-office365-filtering-correlation-id: bdf6950d-c832-4a8d-6a5e-08db93077ea1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Czu4ov5VYIAVVvrm+gjwZ/0+J8fUk000MU/Rh6aWoR5n0vH1nLJ3/73nXOcYn5i71dZNDg47M+1Swj1dt/ctWsRmg78CLx+MQuBYPO3dlPA3vDOrrC9cBgi6OIKmSM81OSya9hg8ErDJBTBhC+xQIxt9qzjozms/EjuabsNJCIo9ThUtT8tjvujHTA7dSnFny1hzlggtt6Lt+cbtflsC2bK97J8JeiPIczuHjA/ffTrP3zFAFrA4r7kC1JwmbO1JyzRcsugmg626pZmR+n1KgRwZXwH4YAl84rBim4ye27MrGZb2xrXhiWqtYGv69A4JhnEKuC69GWIDR7arfmoW5Bih++uDsPosD2XLin1lZ2N8T6F1pMZ/gtpuUmzsVglvSEFIYS7bWD7Xjx3NiV8A4KEwhO74w2QyMlfmilMpo54h6WeSJCapDdqT/ry/5S/4lmAcEGlgs8NKL2J0o8pEQjRpT5vgNUSKFQ1sZtA8G7yWreaRZx8VQ6Ey2eJRo5fMB7R28Gdi2cjruGi2bwEr2p02yGCYCKvB+0gebBHPIVe95t/m14UFX1MQsEsJMVnpBiml4A9mkVZi3YtuLyc17QibqO+3qaLzE1Uo3C5oD8tiqvqPUiWBzEXHFpCBeSg6TxU3XnPc0lPx9W9KEGK7fQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(64756008)(66446008)(66556008)(66476007)(4326008)(52536014)(66946007)(76116006)(2906002)(38100700002)(122000001)(53546011)(186003)(6506007)(26005)(38070700005)(83380400001)(110136005)(54906003)(55016003)(33656002)(478600001)(9686003)(966005)(71200400001)(7696005)(41300700001)(8936002)(8676002)(5660300002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVA1cTZSS0xYSlJmNHpUcEdUaGxSS3BsN2ZHQmk3citwMUIzYnY5bUM4N1BN?=
 =?utf-8?B?ejFQOW4vZGhRWHV4TVQzYlJ2eUY1N0cvM0pKVGZCdzJPbDdDUjB4VlNsU25z?=
 =?utf-8?B?NkJZVm9mSWhxNERvdUFwdSs5UWwxREhpb0loL0poeHUwUktsM2tQUW54Y0JX?=
 =?utf-8?B?REVob2lEeE5LNDVQSzZRaGFnZWxtM3ZxczlnSWxqdzNteE82eFM2dlRtaEVR?=
 =?utf-8?B?dVJVOXBZdjlhNDhzTzFTMkIxVVQwZDlML1RxMWUvakt3YnVMbDNRQVlieGVz?=
 =?utf-8?B?T2hOM2VNTG12aVgzcWNmK0ZSb0themc5NDJNU25FQVNTRTUyTUVmMzN0MzFD?=
 =?utf-8?B?bk1IUHpSenB2UFZMTVJ2akNnUDB4TGxTNDFTamh6U3RTTjhTWTFoS2R1Z21n?=
 =?utf-8?B?VHg3aWRqYlJRT1JoNjU5ajNTQklGZ3ZFbTQwaVJ4S2d0NnBHN2d3SFo1SUpm?=
 =?utf-8?B?ZGJycGxWbGRLWmZjaGUvT0V1Y2pnRHEyaEQwV2RCdVVsWm56ak94S0o3VjJY?=
 =?utf-8?B?a09vbVhSN3ZIcjFObUExaUQ2WndVdFlJYUFzdjB6cC9BeTE3SGo2Z084Yk8z?=
 =?utf-8?B?TGUvY1dEcWhPM2d0UGVISW1oa0I5U3M5bzRnUlNKNW1qN2lSY3JMZHV3aGp4?=
 =?utf-8?B?L3pVNEdpdEpBbXYrdzE5MUk0VUVmUFlJaGtnQ3Y5bFc4dks4ZjlKODBjQ1dj?=
 =?utf-8?B?ZTFyM054Qkd6SEE4VmpJS1pWNEIzd0JneDdrZXN3Qk5MWTNvMnpoc0M3YVor?=
 =?utf-8?B?UXpDVG5EVWZ1dWlvL3U1YUtiNDVSTTdBdU02Wk1EOHZvaDlnd3RsOCt6N2JD?=
 =?utf-8?B?a2dRaGlEY3lob21KOGNDV05CUHRvcTN0NktVTGtjUnhFa29PNDBoTG9xZGxo?=
 =?utf-8?B?M0dTQ2NHTEpodlVwcDNidDcwR2R3bkw4dFRlVk1pWWV1bWNVQjJpZld0MlFG?=
 =?utf-8?B?M1dyQUlld1pPY2hKNElacTA4REI1djkxNGEvWXE3Mk5SYXRHaWk1T1FTVm9B?=
 =?utf-8?B?ajg1VWh3RzZoaC9VNW9oSnFpa2lUZHR5WFFzOVJCVkllblM3ZEZ5WUloZTYx?=
 =?utf-8?B?MzBMMk1nNHB4TjZOUTZuWUozTUV3dGZNMnMvVTJwRWhRYkdKREZ0SVBnbWZo?=
 =?utf-8?B?UmtUUnEzakVyOCt4dGNGUHhvczZ4bktNdi9kQytxOWMvdzRCRU4wRStRdDZ6?=
 =?utf-8?B?QkJaOUlpMkplU0k5UVBPNVBBdjMwWWk2aEwyMnNqdmszaXEzUjlNalZwdFBh?=
 =?utf-8?B?USttQzZPazlRbUtFVkQ3VkZTTnRuLy9rZ2YyTytKMzRMaHNNditqREFXakRm?=
 =?utf-8?B?dHpEb09NdTk5Tk9UWk0wa3lCb2lpMzMzYUhCcDBacmZwSi93TTZuakNVWXJa?=
 =?utf-8?B?cW1Vd09RdXhjdzU2Z1pQMUoxcTliSGtwQithcURhVDhSM1I3OVJSbGZvQnJH?=
 =?utf-8?B?OUh4VnJ5V21uRmJnS01NdTJRalY0U3RTanBtektWNkh2Vm4xTWlYRUJNZUdr?=
 =?utf-8?B?NDVpMXl2RUNraXNmWEJJTUFjNTVoMkFBdnZJUEVlMzhoS0JtUXlCQXd5OFZC?=
 =?utf-8?B?OGpPVWR3NzQxMXBKaGhTSm5BM1padFhnMGVaZE9Oc3BncDlQNG41cHFqaTJB?=
 =?utf-8?B?OEVDRnRaYThZRXNyMjI4SSt1VHVIcnVvYUlaSGhMY253SFM1aGVGcG50SXFn?=
 =?utf-8?B?UDVnU09tNVU1TjdOSytKek1ETGtYakduM3VTR0ZDQXZ1MHFJNjlGKzZmQURu?=
 =?utf-8?B?R01BNWx3ZHU3a3JSUXdBOUFRSGFvV0I5akdCV3A2a0pIOThKRkJlQmJyM01v?=
 =?utf-8?B?MDZPdGtRbkVCd1RKSUFUcUdjRnRmQlZrajE2V2RYSkJHZ0ZZYVdtOHlLb1A0?=
 =?utf-8?B?ZXNPamMrMUZVdXlJck50VlhxQW5VbjBLdWRUM3h3NmhlWFZpZnFYQTk5MWRG?=
 =?utf-8?B?eW5taUU1eWJWNUFwWXBoTUdFVVBtNXJpWkw3aFJuSnlrRkJhS2tHWmM1djlt?=
 =?utf-8?B?ai9icDBMUGFlU29XUnorL1dXNkMxcHVONDZ2OHNaT1BlcE9qcEJiN21zS0dG?=
 =?utf-8?B?dFVBVGROTENyenFpNFJmZ1IwanluZUtQTlN4eUlQYlk5Z01oMzJ1R1UwWkZi?=
 =?utf-8?Q?Qevs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B148E027AA7E14EAEE23F6755D382C2@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf6950d-c832-4a8d-6a5e-08db93077ea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 03:21:00.1572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: co+VVr9qA7FSJ7tF3NOViw4sThRlyXp8GP3jpAWDHZ25rT/Ugk9EH+vBOnvueS21Lbo5UzBv5Yy9fdXxYAxeFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537
Subject: [virtio-dev] Re: [VIRTIO GPU PATCH v3 0/1] Add new feature flag
 VIRTIO_GPU_F_FREEZE_S3

SGkgYWxsLA0KDQpEbyB5b3UgaGF2ZSBhbnkgb3RoZXIgY29tbWVudHMgb24gdGhlIG1vZGlmaWNh
dGlvbiBvZiB2aXJ0aW8tZ3B1IFMzPw0KTG9va2luZyBmb3J3YXJkIHRvIHlvdXIgcmVwbHkgYW5k
IGNvbW1lbnRzLg0KDQpPbiAyMDIzLzcvMjAgMjA6MTgsIEppcWlhbiBDaGVuIHdyb3RlOg0KPiB2
MzoNCj4gDQo+IEhpIGFsbCwNCj4gVGhhbmtzIGZvciBHZXJkIEhvZmZtYW5uJ3MgYWR2aWNlLiBW
MyBtYWtlcyBiZWxvdyBjaGFuZ2VzOg0KPiAqIFVzZSBlbnVtIGZvciBmcmVlemUgbW9kZSwgc28g
dGhpcyBjYW4gYmUgZXh0ZW5kZWQgd2l0aCBtb3JlDQo+ICAgbW9kZXMgaW4gdGhlIGZ1dHVyZS4N
Cj4gKiBSZW5hbWUgZnVuY3Rpb25zIGFuZCBwYXJhdGVtZXJzIHdpdGggIl9TMyIgcG9zdGZpeC4N
Cj4gKiBFeHBsYWluIGluIG1vcmUgZGV0YWlsDQo+IA0KPiBBbmQgbGF0ZXN0IHZlcnNpb24gb24g
UUVNVSBhbmQgTGludXgga2VybmVsIHNpZGU6DQo+IAlRRU1VOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9xZW11LWRldmVsLzIwMjMwNzIwMTIwODE2Ljg3NTEtMS1KaXFpYW4uQ2hlbkBhbWQuY29t
DQo+IAlLZXJuZWw6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzA3MjAxMTU4MDUu
ODIwNi0xLUppcWlhbi5DaGVuQGFtZC5jb20vVC8jdA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBK
aXFpYW4gQ2hlbi4NCj4gDQo+IA0KPiB2MjoNCj4gbGluaywNCj4gaHR0cHM6Ly9saXN0cy5vYXNp
cy1vcGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29tbWVudC8yMDIzMDcvbXNnMDAxNjAuaHRtbA0K
PiANCj4gSGkgYWxsLA0KPiBUaGFua3MgdG8gR2VyZCBIb2ZmbWFubiBmb3IgaGlzIHN1Z2dlc3Rp
b25zLiBWMiBtYWtlcyBiZWxvdyBjaGFuZ2VzOg0KPiAqIEVsYWJvcmF0ZSBvbiB0aGUgdHlwZXMg
b2YgcmVzb3VyY2VzLg0KPiAqIEFkZCBzb21lIGRlc2NyaXB0aW9ucyBmb3IgUzMgYW5kIFM0Lg0K
PiANCj4gDQo+IHYxOg0KPiBsaW5rLA0KPiBodHRwczovL2xpc3RzLm9hc2lzLW9wZW4ub3JnL2Fy
Y2hpdmVzL3ZpcnRpby1jb21tZW50LzIwMjMwNi9tc2cwMDU5NS5odG1sDQo+IA0KPiBIaSBhbGws
DQo+IEkgYW0gd29ya2luZyB0byBpbXBsZW1lbnQgdmlydGdwdSBTMyBmdW5jdGlvbiBvbiBYZW4u
DQo+IA0KPiBDdXJyZW50bHkgb24gWGVuLCBpZiB3ZSBzdGFydCBhIGd1ZXN0IHRocm91Z2ggUWVt
dSB3aXRoIGVuYWJsaW5nIHZpcnRncHUsDQo+IGFuZCB0aGVuIHN1c3BlbmQgYW5kIHMzcmVzdW1l
IGd1ZXN0LiBXZSBjYW4gZmluZCB0aGF0IHRoZSBndWVzdCBrZXJuZWwNCj4gY29tZXMgYmFjaywg
YnV0IHRoZSBkaXNwbGF5IGRvZXNuJ3QuIEl0IGp1c3Qgc2hvd24gYSBibGFjayBzY3JlZW4uDQo+
IA0KPiBUaGF0IGlzIGJlY2F1c2Ugd2hlbiBndWVzdCB3YXMgZHVyaW5nIHN1c3BlbmRpbmcsIGl0
IGNhbGxlZCBpbnRvIFFlbXUgYW5kDQo+IFFlbXUgZGVzdHJveWVkIGFsbCByZXNvdXJjZXMgYW5k
IHJlc2V0IHJlbmRlcmVyLiBUaGlzIG1hZGUgdGhlIGRpc3BsYXkNCj4gZ29uZSBhZnRlciBndWVz
dCByZXN1bWVkLg0KPiANCj4gU28sIEkgYWRkIGEgbWVjaGFuaXNtIHRoYXQgd2hlbiBndWVzdCBp
cyBzdXNwZW5kaW5nLCBpdCB3aWxsIG5vdGlmeSBRZW11LA0KPiBhbmQgdGhlbiBRZW11IHdpbGwg
bm90IGRlc3Ryb3kgcmVzb3VyY2VzLiBUaGF0IGNhbiBoZWxwIGd1ZXN0J3MgZGlzcGxheQ0KPiBj
b21lIGJhY2suDQo+IA0KPiBBcyBkaXNjdXNzZWQgYW5kIHN1Z2dlc3RlZCBieSBSb2JlcnQgQmVj
a2V0dCBhbmQgR2VyZCBIb2ZmbWFubiBvbiB2MQ0KPiBxZW11J3MgbWFpbGluZyBsaXN0LiBEdWUg
dG8gdGhhdCBtZWNoYW5pc20gbmVlZHMgY29vcGVyYXRpb24gYmV0d2Vlbg0KPiBndWVzdCBhbmQg
aG9zdC4gV2hhdCdzIG1vcmUsIGFzIHZpcnRpbyBkcml2ZXJzIGJ5IGRlc2lnbiBwYXJhdmlydA0K
PiBkcml2ZXJzLCBpdCBpcyByZWFzb25hYmxlIGZvciBndWVzdCB0byBhY2NlcHQgc29tZSBjb29w
ZXJhdGlvbiB3aXRoIGhvc3QNCj4gdG8gbWFuYWdlIHN1c3BlbmQvcmVzdW1lLiBTbyBJIHJlcXVl
c3QgdG8gYWRkIGEgbmV3IGZlYXR1cmUgZmxhZywgc28gdGhhdA0KPiBndWVzdCBhbmQgaG9zdCBj
YW4gbmVnb3RpYXRlIHdoZW5ldmVyIGZyZWV6aW5nIGlzIHN1cHBvcnRlZCBvciBub3QuDQo+IA0K
PiBKaXFpYW4gQ2hlbiAoMSk6DQo+ICAgdmlydGlvLWdwdTogQWRkIG5ldyBmZWF0dXJlIGZsYWcg
VklSVElPX0dQVV9GX0ZSRUVaRV9TMw0KPiANCj4gIGRldmljZS10eXBlcy9ncHUvZGVzY3JpcHRp
b24udGV4IHwgNDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspDQo+IA0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlh
biBDaGVuLg0K

