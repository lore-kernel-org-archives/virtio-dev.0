Return-Path: <virtio-dev-return-13429-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB95C001DF
	for <virtio-dev@archiver.kernel.org>; Wed,  2 Aug 2023 05:57:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DA4F62AC53
	for <virtio-dev@archiver.kernel.org>; Wed,  2 Aug 2023 05:57:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C4AB3986699
	for <virtio-dev@archiver.kernel.org>; Wed,  2 Aug 2023 05:57:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B6B3F9849DE; Wed,  2 Aug 2023 05:57:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A13EB9865EC;
	Wed,  2 Aug 2023 05:57:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IK2e2jHaIU12XfP6VSOYs2oHKoIyUjARViG566k+Yc3lsUDVSsWLQL8xxuD1tPl+dwBXbwJ8KntUK5f+1dyb5OTw+w68xYbJ3jOSELai/Vn/ogz8rtYgbhpoS1zu8XxNLOLlCRKPEOWunUPAGbqq0YABSixeM/6drRGXT3J5FJD+G8ZjQFA+pXCGOKBj1i1i4LZpNnG9uVrjMtOezlCdw9cSS9D1E15YeKvqvPZaRBqthq6koHnIWn6SaBnbFN4dNtSBn4BPJLE3g3TzhDIns42Ot57vbB3sfF6c5m87kIO06pBe25i5UoVFZyKqowDK1FJ+P0KNnnUJFFQ+nyPmgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vv94h36Re/o9SydMmhEDQ5L3kMybCsc5enXfx2RDRHg=;
 b=DGUHYgqF7QTfKX/jZ9BEWkEMZfHo/U74e2ZGJB++YRPYT3TaXc2QyBX12/kKkBGW38xODECzCb4/h4KNHAItUduV/zx0vB6xfakZPwFtF89UWGFXl5jE6tyb2W5hrpTslhaDJVNkr57fC8aStLz8CsFPVKRGmXAROxxuIN209ovpdETj6/azo6xMYuPqwI9HphPOUetL6G2Khp/QMUqcWaGdqfPwC9VHjlqcWX8xxKGY+fCXqeS5qyfHZOYR/B6363+dpia5U4WtNLl0/hyVchAxJ4Z2d95fwkl9qMOM2Y1xBA5A8msI/lluJvmDBk7FZIBV+wk2LR5fCCR+YDC5OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Parav Pandit <parav@nvidia.com>
CC: Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
	<marcandre.lureau@gmail.com>, Robert Beckett <bob.beckett@collabora.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Stefano
 Stabellini <sstabellini@kernel.org>, =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=
	<roger.pau@citrix.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>, "Hildebrand, Stewart"
	<Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia"
	<Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian"
	<Jiqian.Chen@amd.com>
Thread-Topic: [VIRTIO GPU PATCH v3 0/1] Add new feature flag
 VIRTIO_GPU_F_FREEZE_S3
Thread-Index: AQHZuwRh6691cWFD3EGobeyAVCVbhK/W7j4A//+VJgCAAI+1gA==
Date: Wed, 2 Aug 2023 05:57:47 +0000
Message-ID:
 <BL1PR12MB5849A2599DD46405262B8630E70BA@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20230720121844.8956-1-Jiqian.Chen@amd.com>
 <BL1PR12MB5849C19607B02CDA76BD9F61E70BA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481C2248C74E551B3318DD8DC0BA@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB5481C2248C74E551B3318DD8DC0BA@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: IA1PR12MB6553.namprd12.prod.outlook.com
 (15.20.6652.008)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|PH0PR12MB8823:EE_
x-ms-office365-filtering-correlation-id: 972afe09-a782-4e5c-2fde-08db931d6607
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 y4jODODz9FxBhPDGGQJ5Tz7yGMutHh84CWSOxEynPU358G3AF0Glzn8gQVel1c5q/yKoMhXdHDalHKN26TQmT2Q+A7Z2RVmZhj5f+F0Q/R/Z/Qt16Og0zcj+1W1Q7DVV3bDCzOs/OAvM4uB3dQTkGta5mXJuqjuvZoGqh6pr31HQMFBIrvDmWAvMqVdTgj6cpl1nF8XxDrE9n/ClHkgnTPcikqsRJv8bUq7mzwEj7qZd4+C34rQ1fAW7bhGEGbHSq3QBNtUZIwKVdDVpqjfeM7Z+G7HYyo6Bh8NRDakq7pY/C6QZZI4H3+A3XuhXex+DBwkkwEJhcqHudL2aMqkZzpsywSME1tLFUyiV129lDnRuSwdERlfKCkBbaz5SafSvCdZXQEFN3a1LiDpFTMzqD2yqEAC9bl30usd2fhYq6csPKltac2UMuCNLi24+GQItCgNChbLhyXP84fEffOEme9gBTB1LsUYwXM1q18IBYQcYrSe9tiwoc1bLCEtZUbHA4JXJ8dpa5wuYExL16W2ObKxRYbXFebEN7NeD1N9YoclR8TbAcpxtYHMxWtb2Ll2hP6M+o5fznc+l7YFe5yUDQDyWqC3Mq39DDMfpgNEU6op0PBiccIwgih+XhC+jxqcA4PAzZCxFjiY/hjhrde6slw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199021)(52536014)(5660300002)(53546011)(8936002)(6506007)(186003)(8676002)(83380400001)(478600001)(26005)(76116006)(66446008)(4326008)(54906003)(6916009)(66946007)(66476007)(66556008)(316002)(64756008)(7696005)(41300700001)(71200400001)(966005)(9686003)(38070700005)(55016003)(33656002)(2906002)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THNHczg3dmhLQngzeElwdjArS0pqMFFZQnBOcXpFVVd6OVYzTmpQS0FTQzNV?=
 =?utf-8?B?dGM2L0dlejNIUnhWb1JISHpqUTZLdlBUTVhUeWkzZ29raFVPQkRjcnlqb2Z2?=
 =?utf-8?B?UlJtTWRQYnFyM1FqUGZLa2VFY095bjRWS3BhN0p5cFhkb0NLYnVlTjJOUmVV?=
 =?utf-8?B?NDBZQnJ3S2g3b1BQR3J1YlZMd01SajlMSk1PNVdSMXYrd3IzbDdXQ0xUNCtT?=
 =?utf-8?B?T0h1L1M2dVVOQWJXeDBVbWZjb3BSbHV5Ujl0SWpLN0FqZXR1SmVhWFEvT3Aw?=
 =?utf-8?B?cCtwS0NoNlNhbjVKSTBnN1lSbHdUZDhUNTVBaUdNRlVKKy9IODJNeEx5SUpp?=
 =?utf-8?B?UFJtcWhiMDlsWDVtMnNWdmRYN3M3SUZVTTdnQkVlZVB5VmEyc0psOVdRRUlr?=
 =?utf-8?B?d2VRL2Z3bHFzMkVKVEhiazIwOUFZTTVpR2ZRRC9hUVY2SEFLMWFZYjZQUkxJ?=
 =?utf-8?B?UDdGQkQxWkE1TkpXNHlWRzFjWHFxcHZEbm1sRmtGZkJhVVNwemhiRzRQWUJN?=
 =?utf-8?B?VVIxVlRXK0pOd0V3YzE1U3p6ZmpSZnd1MkNBbFkyVW1DblZ0OXNmS0l0Wkg3?=
 =?utf-8?B?OUZ4VEF6Z1ZJeWQ5eVRnM1piL3M3VUYrb1l3aHU0c3dhbEtxN3ZPTFBPKzVo?=
 =?utf-8?B?SGNRRUl5dW9OcHN0SHNFL2s4eVVmM0FBS2VIUEwvb2Z3L0dOS0xSODBDZ1V5?=
 =?utf-8?B?ckxITmQ1QjYzKzNTMk9zUTMzekF2UEJ2ZTRoZFBDRkhwaDJwMjJmSTJGR01n?=
 =?utf-8?B?cGk1aUJ4SUJUWko4SE9tT0JDelM2eVFpWVkyQ2dBM05RZVJNaVVwMW1TNWli?=
 =?utf-8?B?NUUxaWpBcWx4RERyaXJzUlBHNnFKWkZZUkxnaFJ1YmVUcWkweGJPZ2FPcENq?=
 =?utf-8?B?MGYzOGNOV3hGNDhmZFNiUnU1clFORGo5QXV5bm51L3JVVDY2NGp3K0Q3VXpI?=
 =?utf-8?B?ZUpuVEllMW03YVhwenlWWVFHeWhNZ1JuQjcyMnh3MGYwY3RVTGNIcnVGNjdq?=
 =?utf-8?B?bW1OcWIxODFYa0lveEhadUVhbWRrbWFRdEJLL2RWSGQ5Y2E5eDJSQk1WV3R1?=
 =?utf-8?B?cWhES1RCeXFXa1NiR0RPM0c5SzhPZEpqTDZUQ3lCK21LZlVyTjhXcGRuaWpI?=
 =?utf-8?B?NE8wc1hENFhyVlZZa3dtb0RwN3NwQ252dHJnaDZUaGppVDVPZGs5Zm9pUDZv?=
 =?utf-8?B?SXZGZjNDaDRNQzg1bC94RWRWNVNsWStTUmVVNGZTR1JNUklDVmlhSEJLVzRz?=
 =?utf-8?B?RTBUemVqSUtYQzQ1eFVCM0lhRW0xaDh1WWV1VksrZGJ0RzAyY2dtVFJvVmFY?=
 =?utf-8?B?d3V1WnBVeS9xK2FJaFpoSWE5RXdWMHBXSisxNXF6NERWUHhnSVRMd0FzaWFQ?=
 =?utf-8?B?VWE1M1F1R0hha3ZqUU81UGxHUmhOaFBQUitocldBZURHQzFDczFTMGs4VURK?=
 =?utf-8?B?NzNqTkdhMEluM21HNnBidTV1cWQ0c29XK3Y0aGRUK0NKTnIyY1lmNng2ZHo5?=
 =?utf-8?B?YUI5OEsxcHNzRXpKYk16V1N5K1FvOVpzQkxUcHVRL3hKa0ljc2dwd0FvbHhP?=
 =?utf-8?B?RXA0Z3NBaU1HQklxQWc0VWxaMVVobHpiUzc5NEZWOHdsL01kUmxHZU5yTVps?=
 =?utf-8?B?OC9xYmJKQUQzT0lMNGZYRDlUUk9vOHhKODBxZnFnUjliTnJvbmlKcGF3Y3hC?=
 =?utf-8?B?UWxlQ3NoSjVzVU1YcXIrMjNPd08zYk85Rnd0czVGYlZTT3BQSzM1Y2hrN3F5?=
 =?utf-8?B?bmh0cmI5LzdyTTB3T3NLTlpoMnRKUXNZUGZ5cjJldEUwaGYyd0pMWDBROTI2?=
 =?utf-8?B?KzRnVzdocDhZalY4QUNVWUgwYXowM0tNMkNYSUpXVmdXNHBld1ZUakFseHdS?=
 =?utf-8?B?NFNHOG1ySkJoYW1IQU4ydXRFWHpsUTNUaGtEU0F2WjNRQ0xFa1pQQThFVWN0?=
 =?utf-8?B?clBObm15U0wwZFRpMnhnUmZibUtyaGRqR0lFRGlOYU1kTU1yWWQ5Y0k2Qmtk?=
 =?utf-8?B?eFBtaUlEbXNEQjVEcTRjNytkUEx0Vm13Uzd0NzM5blNidS9jR05rL1M1aytV?=
 =?utf-8?B?SVRMVCtxT1poVE4waDNoVjFJQUluOTlBbExDL0VVMVpNekRZSitHcVhZd2VQ?=
 =?utf-8?Q?9WQ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68DD76854534CF42AF7939C207022D9A@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972afe09-a782-4e5c-2fde-08db931d6607
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 05:57:47.7804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tPoRGiC7GwEodVGk1gFE5PyyLwhp+u/ThdOM0a0ZgpUzSL9E3TuLl38vGBT13aqkxMznOxbbuWqSOuzocSG5/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823
Subject: [virtio-dev] Re: [VIRTIO GPU PATCH v3 0/1] Add new feature flag
 VIRTIO_GPU_F_FREEZE_S3

DQpPbiAyMDIzLzgvMiAxMjo0OSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiANCj4gDQo+PiBGcm9t
OiB2aXJ0aW8tZGV2QGxpc3RzLm9hc2lzLW9wZW4ub3JnIDx2aXJ0aW8tZGV2QGxpc3RzLm9hc2lz
LW9wZW4ub3JnPiBPbg0KPj4gQmVoYWxmIE9mIENoZW4sIEppcWlhbg0KPj4gU2VudDogV2VkbmVz
ZGF5LCBBdWd1c3QgMiwgMjAyMyA4OjUxIEFNDQo+PiBIaSBhbGwsDQo+Pg0KPj4gRG8geW91IGhh
dmUgYW55IG90aGVyIGNvbW1lbnRzIG9uIHRoZSBtb2RpZmljYXRpb24gb2YgdmlydGlvLWdwdSBT
Mz8NCj4+IExvb2tpbmcgZm9yd2FyZCB0byB5b3VyIHJlcGx5IGFuZCBjb21tZW50cy4NCj4+DQoN
CkhpIFBhcmF2IFBhbmRpdCwNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4gTGV0IG1lIHRyeSB0
byBhbnN3ZXIgeW91ciBxdWVzdGlvbi4NCg0KPiBJIGFtIG5vdCBmYW1pbGlhciB3aXRoIHRoZSBH
UFUsIHNvIGEgZHVtYiBxdWVzdGlvbiBpcywgd2h5IHRoZSBTMyBzdGF0ZSBpcyBncHUgc3BlY2lm
aWM/DQpTMyBzdGF0ZSBpcyBub3QgZ3B1IHNwZWNpZmljLiBJIHRoaW5rIGRpZmZlcmVudCB2aXJ0
aW8gZGV2aWNlcyBtYXkgaGF2ZSBkaWZmZXJlbnQgYWN0aW9ucy9wcm9ibGVtcyB3aGVuIFMzLiAN
CldoZW4gSSBkbyBTMyBvbiBYZW4sIEkgZm91bmQgZ3Vlc3QncyBkaXNwbGF5IGNhbid0IGNvbWUg
YmFjayBhbmQgdGhlIHJvb3QgY2F1c2UgaXMgaW4gdmlydGlvLWdwdSBiYWNrZW5kIGluIFFFTVUu
DQpTbywgdG8gc29sdmUgdGhhdCBwcm9ibGVtLCBJIGNoYW5nZSBjb2RlcyB0byBsZXQgZ3Vlc3Qg
bm90aWZ5IFFFTVUgdmlydGlvLWdwdSdzIHN1c3BlbmQgc3RhdGUsIGFuZCB0aGVuIFFFTVUgd2ls
bCBub3QgZGVzdHJveSByZXNvdXJjZXMgdGhhdCB1c2VkIGZvciBkaXNwbGF5Lg0KUGxlYXNlIHNl
ZSBhdHRhY2hlZCBrZXJuZWwgYW5kIFFFTVUgcGF0Y2ggbGlua3MuDQpGb3IgYWJvdmUgcmVhc29u
LCBHZXJkIHN1Z2dlc3QgbWUgdG8gYWRkIGEgbmV3IGZlYXR1cmUgZmxhZyBzcGVjaWZpY2FsbHkg
Zm9yIHZpcnRpby1ncHUsIHNvIHRoYXQgZ3Vlc3QgYW5kIGhvc3QgY2FuIG5lZ290aWF0ZSB3aGVu
ZXZlciB0byBlbmFibGUgYWJvdmUgbWVjaGFuaXNtLg0KDQo+IENhbiBhIHRyYW5zcG9ydCBzcGVj
aWZpYyBzdXNwZW5kIHN0YXRlIGJlIHVzZWQgYW5kIGFwcGx5IHRvIGFsbCB2aXJ0aW8gZGV2aWNl
cz8NCkJhc2VkIG9uIG15IGxpbWl0ZWQga25vd2xlZGdlLiBEaWZmZXJlbnQgdmlydGlvIGRldmlj
ZXMgaGF2ZSBkaWZmZXJlbnQgdmlydGlvIHF1ZXVlcywgbXkgbW9kaWZpY2F0aW9ucyBsZXQgZ3Vl
c3QgdG8gbm90aWZ5IFFFTVUgYnkgdXNpbmcgdmlydGlvLWdwdSdzIGNvbnRyb2wgcXVldWUuDQpP
dGhlciB2aXJ0aW8gZGV2aWNlcyBjYW4ndCBnZXQgdGhhdCBub3RpZmljYXRpb24gdW5sZXNzIHlv
dSBjYW4gdHJhdmVyc2UgYWxsIHZpcnRpbyBkZXZpY2VzIGFuZCBub3RpZnkgb25lIGJ5IG9uZSwg
b3Igb3RoZXIgZ2xvYmFsIG1ldGhvZD8NCkJ1dCBmb3Igbm93LCB0aGlzIHBhdGNoIGlzIHRvIGFk
ZCBhIG5ldyBmZWF0dXJlIGZsYWcganVzdCB1c2VkIGZvciB2aXJ0aW8tZ3B1Lg0KDQo+IEFuZCBj
YW4geW91IHBsZWFzZSBhZGQgYm90aCB0aGUgcmF0aW9uYWxlIHRvIHRoZSBjb21taXQgbWVzc2Fn
ZT8NClN1cmUsIEkgd2lsbCBleHBhbmQgdGhlIGRlc2NyaXB0aW9uIG9mIG15IGNvbW1pdCBtZXNz
YWdlIGFuZCBhZGQgdGhlbS4NCg0KPiANCj4+IE9uIDIwMjMvNy8yMCAyMDoxOCwgSmlxaWFuIENo
ZW4gd3JvdGU6DQo+Pj4gdjM6DQo+Pj4NCj4+PiBIaSBhbGwsDQo+Pj4gVGhhbmtzIGZvciBHZXJk
IEhvZmZtYW5uJ3MgYWR2aWNlLiBWMyBtYWtlcyBiZWxvdyBjaGFuZ2VzOg0KPj4+ICogVXNlIGVu
dW0gZm9yIGZyZWV6ZSBtb2RlLCBzbyB0aGlzIGNhbiBiZSBleHRlbmRlZCB3aXRoIG1vcmUNCj4+
PiAgIG1vZGVzIGluIHRoZSBmdXR1cmUuDQo+Pj4gKiBSZW5hbWUgZnVuY3Rpb25zIGFuZCBwYXJh
dGVtZXJzIHdpdGggIl9TMyIgcG9zdGZpeC4NCj4+PiAqIEV4cGxhaW4gaW4gbW9yZSBkZXRhaWwN
Cj4+Pg0KPj4+IEFuZCBsYXRlc3QgdmVyc2lvbiBvbiBRRU1VIGFuZCBMaW51eCBrZXJuZWwgc2lk
ZToNCj4+PiAJUUVNVTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDIzMDcy
MDEyMDgxNi44NzUxLTEtDQo+PiBKaXFpYW4uQ2hlbkBhbWQuY29tDQo+Pj4gCUtlcm5lbDoNCj4+
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMwNzIwMTE1ODA1LjgyMDYtMS1KaXFp
YW4uQ2hlbkBhbWQuY29tDQo+Pj4gL1QvI3QNCj4+Pg0KPj4+IEJlc3QgcmVnYXJkcywNCj4+PiBK
aXFpYW4gQ2hlbi4NCj4+Pg0KPj4+DQo+Pj4gdjI6DQo+Pj4gbGluaywNCj4+PiBodHRwczovL2xp
c3RzLm9hc2lzLW9wZW4ub3JnL2FyY2hpdmVzL3ZpcnRpby1jb21tZW50LzIwMjMwNy9tc2cwMDE2
MC5oDQo+Pj4gdG1sDQo+Pj4NCj4+PiBIaSBhbGwsDQo+Pj4gVGhhbmtzIHRvIEdlcmQgSG9mZm1h
bm4gZm9yIGhpcyBzdWdnZXN0aW9ucy4gVjIgbWFrZXMgYmVsb3cgY2hhbmdlczoNCj4+PiAqIEVs
YWJvcmF0ZSBvbiB0aGUgdHlwZXMgb2YgcmVzb3VyY2VzLg0KPj4+ICogQWRkIHNvbWUgZGVzY3Jp
cHRpb25zIGZvciBTMyBhbmQgUzQuDQo+Pj4NCj4+Pg0KPj4+IHYxOg0KPj4+IGxpbmssDQo+Pj4g
aHR0cHM6Ly9saXN0cy5vYXNpcy1vcGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29tbWVudC8yMDIz
MDYvbXNnMDA1OTUuaA0KPj4+IHRtbA0KPj4+DQo+Pj4gSGkgYWxsLA0KPj4+IEkgYW0gd29ya2lu
ZyB0byBpbXBsZW1lbnQgdmlydGdwdSBTMyBmdW5jdGlvbiBvbiBYZW4uDQo+Pj4NCj4+PiBDdXJy
ZW50bHkgb24gWGVuLCBpZiB3ZSBzdGFydCBhIGd1ZXN0IHRocm91Z2ggUWVtdSB3aXRoIGVuYWJs
aW5nDQo+Pj4gdmlydGdwdSwgYW5kIHRoZW4gc3VzcGVuZCBhbmQgczNyZXN1bWUgZ3Vlc3QuIFdl
IGNhbiBmaW5kIHRoYXQgdGhlDQo+Pj4gZ3Vlc3Qga2VybmVsIGNvbWVzIGJhY2ssIGJ1dCB0aGUg
ZGlzcGxheSBkb2Vzbid0LiBJdCBqdXN0IHNob3duIGEgYmxhY2sgc2NyZWVuLg0KPj4+DQo+Pj4g
VGhhdCBpcyBiZWNhdXNlIHdoZW4gZ3Vlc3Qgd2FzIGR1cmluZyBzdXNwZW5kaW5nLCBpdCBjYWxs
ZWQgaW50byBRZW11DQo+Pj4gYW5kIFFlbXUgZGVzdHJveWVkIGFsbCByZXNvdXJjZXMgYW5kIHJl
c2V0IHJlbmRlcmVyLiBUaGlzIG1hZGUgdGhlDQo+Pj4gZGlzcGxheSBnb25lIGFmdGVyIGd1ZXN0
IHJlc3VtZWQuDQo+Pj4NCj4+PiBTbywgSSBhZGQgYSBtZWNoYW5pc20gdGhhdCB3aGVuIGd1ZXN0
IGlzIHN1c3BlbmRpbmcsIGl0IHdpbGwgbm90aWZ5DQo+Pj4gUWVtdSwgYW5kIHRoZW4gUWVtdSB3
aWxsIG5vdCBkZXN0cm95IHJlc291cmNlcy4gVGhhdCBjYW4gaGVscCBndWVzdCdzDQo+Pj4gZGlz
cGxheSBjb21lIGJhY2suDQo+Pj4NCj4+PiBBcyBkaXNjdXNzZWQgYW5kIHN1Z2dlc3RlZCBieSBS
b2JlcnQgQmVja2V0dCBhbmQgR2VyZCBIb2ZmbWFubiBvbiB2MQ0KPj4+IHFlbXUncyBtYWlsaW5n
IGxpc3QuIER1ZSB0byB0aGF0IG1lY2hhbmlzbSBuZWVkcyBjb29wZXJhdGlvbiBiZXR3ZWVuDQo+
Pj4gZ3Vlc3QgYW5kIGhvc3QuIFdoYXQncyBtb3JlLCBhcyB2aXJ0aW8gZHJpdmVycyBieSBkZXNp
Z24gcGFyYXZpcnQNCj4+PiBkcml2ZXJzLCBpdCBpcyByZWFzb25hYmxlIGZvciBndWVzdCB0byBh
Y2NlcHQgc29tZSBjb29wZXJhdGlvbiB3aXRoDQo+Pj4gaG9zdCB0byBtYW5hZ2Ugc3VzcGVuZC9y
ZXN1bWUuIFNvIEkgcmVxdWVzdCB0byBhZGQgYSBuZXcgZmVhdHVyZSBmbGFnLA0KPj4+IHNvIHRo
YXQgZ3Vlc3QgYW5kIGhvc3QgY2FuIG5lZ290aWF0ZSB3aGVuZXZlciBmcmVlemluZyBpcyBzdXBw
b3J0ZWQgb3Igbm90Lg0KPj4+DQo+Pj4gSmlxaWFuIENoZW4gKDEpOg0KPj4+ICAgdmlydGlvLWdw
dTogQWRkIG5ldyBmZWF0dXJlIGZsYWcgVklSVElPX0dQVV9GX0ZSRUVaRV9TMw0KPj4+DQo+Pj4g
IGRldmljZS10eXBlcy9ncHUvZGVzY3JpcHRpb24udGV4IHwgNDINCj4+PiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPj4+ICAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygr
KQ0KPj4+DQo+Pg0KPj4gLS0NCj4+IEJlc3QgcmVnYXJkcywNCj4+IEppcWlhbiBDaGVuLg0KDQot
LSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0K

