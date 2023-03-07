Return-Path: <virtio-dev-return-11489-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2454EC678D4
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 18:33:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3C5C43249
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 18:33:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 35A6A9866DF
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 18:33:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 285D59866CF; Tue,  7 Mar 2023 18:33:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0F9519866D0;
	Tue,  7 Mar 2023 18:33:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwUa0XocHKtTh0OPhiJ59gOA7H/sy0ISAKUhut+t8Oe1KLvT///jodpFGupz72EqTdUgVyZWoy7HCA6vPG4hJuLicDRQSHU49nEPYxzu6gAuGV2VRSpBgCbdXJujSo1RrWtuHqTKBMMeahdbwSTNaJSsOy5dAfFgUt/JCLkqB8zw9CZT/SnvNI+xBzAbGt85yHDXHj4Z5mJDD1gdYQyJKpUd1+mmou8swgswjNBujTu3Yax7iuGPomgGpfcTGjLvSXH4aW+iyiF2+YV5IlkhXllDcOGqirjMtFDLy3hrvecYL5rgA17Zk3EDrnTmi0BbIncIYW8tJsP0rjt84tV5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+jTCrwXrSYln6Q5MLnfn2znvgLA1a49l7Xwx+PSv/M=;
 b=EfyqZe6H271JGzWyeJ/X1rmSvY6PPcLSfCdzfI4mnEtnD7RLwhPKOHMPioc8Z3omI6zoaJQFQVGgJ0nYKzg9GKvzRrV+JP6G7oD8KIqsmnBJcv2A0zOrkc/s/ulzU5jUBOeN9vCTyRF/gfFSxHKyTbXJJkSdiNDl5LpSFaL5qAfLQVtB36O1NabfGx0E+j8vdUf3AxKq/B7VyC7Pxe/bCXGMqR7UayaINwMl11SPLUzTS7myFQIb4bVjlt8CO9xlk3xX1loal/39NjXYuXE4UAtNYxP1ae0k7Kfe3Sxim8oPiQNOAOz6dnlu6XkW2QH9r29C3LVjHDiNKr4yKF5rSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "nrupal.jani@intel.com"
	<nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v10 03/10] admin: introduce group administration commands
Thread-Index: AQHZTdJ4xYP6q68fXEe3YRvTaF+rUK7pCgmAgASROQCAAg5IYA==
Date: Tue, 7 Mar 2023 18:33:05 +0000
Message-ID:
 <PH0PR12MB548151F882C0A7DABC037979DCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
 <PH0PR12MB548116853CAC23DF9CA7345EDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230302201912.GC2554028@fedora>
 <20230302185803-mutt-send-email-mst@kernel.org>
 <20230303131703.GB2866370@fedora>
 <20230303081900-mutt-send-email-mst@kernel.org>
 <4f869944-4ccd-c51e-0f30-dc3ba15ffd52@nvidia.com>
In-Reply-To: <4f869944-4ccd-c51e-0f30-dc3ba15ffd52@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN2PR12MB4255:EE_
x-ms-office365-filtering-correlation-id: b3982239-d976-4b39-83d3-08db1f3a6453
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HeQNHtO3JPl6wjri/v0NUlwNStdoHmgTvk1x6IlNiYiu87TuTneNFE1riSn7+rwj9QmKQ0AyVAPbRmKv3u+plXfWDOLlI//A7TiO/qCDyky+olQAWWbUCr/6T1D/LkN6URqpPfAbVAHQLTkHxBqxNcsjzB9i3Hme5LW2HLgByDp2Bux67xORfpGUOfARANTUnAkyvJ+UswKGn3cb1swe+96xJ7GPKu1VqXfzXt8dDHqEvfr948TTR9DF5R5f0HcR6dqkE0pjiFu1BBPz5wRqdbh1MDfO7XXTfFvc6jmI71WGmv6ZEeZV6jUEUfT61T7Shzu9TwidTNoPfAFuQcgvcFmrRbS/6wG0r1BlsmLL9wAfXLeO4eFD2yev3MJl72QcSEBmM54R6WiQyliaMwcwNvPgfEoyNs4ml3X6XQ8TQC7P8q9DHRGQrKbMuTOsZnbi0EZ3k1sSWTX3DHNXy0JyhLPH9NFVK93gzGbYvymrPXCD68mwq6cKRtvRMalLqgfyNmNz8C0j7KRiCJuEuHr2/VPO3IGpd5eF2s5LGeUTUKICBpmZWQd3to442BmLdKq7At511gYFuPhIbWaF3/hreS2nciTNeOnNifUa9TZmLcaIXLTX6K6kUU+BGzgp4t7ZKKkFTI4veP8qSyQIVmARi9Bk7uzrEw7e9MIgTmcywSqhFM1cZAsr+zmzfmSQL0dV5+5Pvw/gsqAhDrLiyoKBLQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199018)(122000001)(38100700002)(38070700005)(86362001)(66946007)(66556008)(66446008)(33656002)(66476007)(8676002)(107886003)(52536014)(5660300002)(2906002)(7416002)(76116006)(64756008)(4326008)(8936002)(41300700001)(186003)(9686003)(53546011)(26005)(83380400001)(478600001)(55016003)(110136005)(6506007)(54906003)(71200400001)(316002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUVDcnlCNTJ2TmYzM3h3MTl5MkVJb29SSXZRMXB5WUE5ZWkvcU52Qk5zTFpt?=
 =?utf-8?B?K2xuOEtQUE1XVzJxYjBEemR3WGg0dS8rdGMyZDdBbG1scE9YTEdYY1VydE8y?=
 =?utf-8?B?ekF2aWtUcFpwYmpFRm9ZdTc1dnJVd3RET21ONlF6czh1K2VROTdiZ3kwcmFx?=
 =?utf-8?B?RngyeXNUczBkN01vcy9BUkpOemwrSFNLWDBHeFdaZE4wS2wrMlRDTjFnTUIr?=
 =?utf-8?B?cmo4eHh2VWl6MXJuM2N0eWVibWdKdElWOEtzTnczNGVJcStpOGFIVUFqVnJm?=
 =?utf-8?B?eDlSWkVJbld0R0l6NDBaMXByUk1vUVZWVG95dERCZGxKZDQ0UzREd2JTSmVD?=
 =?utf-8?B?bzdVN1BzYlpndm9ob05wOVNxWFVyQmIzNnF0WTBUclMvb0I1azJLdkNuMXps?=
 =?utf-8?B?T2xrTk9JUUdEQmJ6M09PbjZXY254VUQzaGw3NldPTjZJVFdGTkVMSWFDZVQv?=
 =?utf-8?B?VzE3ZEFHSDNqcXloRGo4YTR6QjZKaU0vb0dKeDJhWkhQLzFPaXk5WGhxUWJj?=
 =?utf-8?B?VXNJWWc2OWtGU0V1S2V2UkdCTWFkeDdkT1pweHFyQjloejczaWc1SzVDdTUz?=
 =?utf-8?B?YU5FcHNWYTZLZnAyM3ZDeG52SEpNUTJJZEF4dzNTMGZHbXFXb05UTnh0blpz?=
 =?utf-8?B?V0NPQ2NHeFdyWE5SdmhRcGVuR2pONWxQRVNpdXZ0RCsxUnBrTkFLVWRucStP?=
 =?utf-8?B?a1BrU01zVVFkRHhrNWFFcnhqSzNGMlZScFZuQy9TeTZrWEREOHNPN3diWVNR?=
 =?utf-8?B?Mk1uYTVJVy9oNVJZT0hGS2NDcTRmNlBSMjhKQU5KeVJ3NFUvSy9ockZ1S0d3?=
 =?utf-8?B?b2wza3kzM1Y1WWVQOEtxa0lXb0JSajZiSFFFeGpMZm1adzBJdTdYS0ViUklh?=
 =?utf-8?B?YkYrRm43d053eTl3SzlvMUIxdDdGdDZub051QVlwSVREZm96amlTNCtaN1kz?=
 =?utf-8?B?L2ZwdDdCV09CQWo4dE9tTmpabXo0ZWdMbGV6SzNHNWZHNzh2L2dzQXE5WVlH?=
 =?utf-8?B?VGZ2bmx2amVKZXBtQ3BKNGx5Mmo2RDA5VGVoVFJwZ1Y4NEtOU1JqMWlaVURX?=
 =?utf-8?B?ZXZSUTErMHNlSGJRY2ZlSlRrKzk0QjgrRmdNL1ZmY3Z1YW5Eczk2M0Z2ejNO?=
 =?utf-8?B?c3l6bVh3U25NSkhFeVBUOFlpVHliczh5dCt0MkdGUi90cWY0dndyQ2NNWHMr?=
 =?utf-8?B?YjFwNXhORGFRWVRtYUFGNFU2WlU4QjRPVVNMd2hxYk15Rlpic1UrUVUvU1Jo?=
 =?utf-8?B?REozem1ENkthMDllZEJDN2h5YmxVVjFTMDJKSHZidldKTXNRQnhPdDAyc1RT?=
 =?utf-8?B?VVp1dXJzZWpGZmFJTEoybHFNRzlvNDRvS3k2bWtlUUZaK29abkM0M0Rua05w?=
 =?utf-8?B?aXFNT0tSanNTSE9xQUVFa0VTbUhCaEtOcUM3L01XS1B5bFpVRG1TSGs2NmZi?=
 =?utf-8?B?NTJpUmczWEdrQWRMMFFUemVISjFuYWdGRXRhNGUwYjZPVDRib0FPeFBRSElX?=
 =?utf-8?B?d0JGaFhBWHhxTFdGOXUwbFJvWktYaUtQVjRNWnBzSXpnb0ZNcEtwTEhraWxi?=
 =?utf-8?B?QjdadzZkdWoxVlA0YWhTMHRiMUxpdHdqSHE4dFQ2Zy9BMTV2Q3VCdkd4bW5N?=
 =?utf-8?B?UWs3dHphS01KZ1VFVEVqMytYSTNycmpmZEw4bDUzVkNIU09sOWIzTzdSYVNu?=
 =?utf-8?B?aEc3YVRNc1Z4Z0xlaFZXeFNoR0RmbmoxRVMrQmFWdy9vQUJ3NG5uNnp4ZXpi?=
 =?utf-8?B?NnkyTkRyMVBNR01RN250cUh6b3RNMFZwWXdta1lHdGVVRnZ0TWM4VEpFNkFl?=
 =?utf-8?B?ZG1VNkVRdC9CQ3dia3p5OWpVUU1jSGR5bFZ3NmdPNmNCczV0Rm9HeVdpR0RD?=
 =?utf-8?B?aVdRTnpMSmRWQ0MxZFdkSm5sVW5vZVExeWlRUGhDZEpoWC9XRjZCV0o4Zm5u?=
 =?utf-8?B?dHZBL2l3eFBldGZpeW5kdXpBTFVycTkvbFpkSE9pREkyOTREZDZJQUVRUklu?=
 =?utf-8?B?aFh0UmRpVTE5UXUvRUZRSXUrek1mSERMYVlBWE1QL0FkMWxmRXZ3SmY0cHhG?=
 =?utf-8?B?RExJQVpGT2ZTZ2sxbUlzTVNMK0lCM21CREZJdVA2YTRmTGZYenVtbjkrNHVx?=
 =?utf-8?Q?lbhU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3982239-d976-4b39-83d3-08db1f3a6453
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 18:33:05.4659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ksVNLOmepolPeeb4o0tzI5YlXvILCY7pBgCEcr4DSfUrwWrpxicxorQVrT3JYwxDewFx0+EgKf2+ssY1ZhAgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
Subject: [virtio-dev] RE: [PATCH v10 03/10] admin: introduce group administration commands

DQo+IEZyb206IE1heCBHdXJ0b3ZveSA8bWd1cnRvdm95QG52aWRpYS5jb20+DQo+IFNlbnQ6IE1v
bmRheSwgTWFyY2ggNiwgMjAyMyA2OjA1IEFNDQo+IA0KPiBPbiAwMy8wMy8yMDIzIDE1OjE5LCBN
aWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+ID4gT24gRnJpLCBNYXIgMDMsIDIwMjMgYXQgMDg6
MTc6MDNBTSAtMDUwMCwgU3RlZmFuIEhham5vY3ppIHdyb3RlOg0KPiA+PiBPbiBUaHUsIE1hciAw
MiwgMjAyMyBhdCAwNzowMTo1NlBNIC0wNTAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+
ID4+PiBPbiBUaHUsIE1hciAwMiwgMjAyMyBhdCAwMzoxOToxMlBNIC0wNTAwLCBTdGVmYW4gSGFq
bm9jemkgd3JvdGU6DQo+ID4+Pj4gT24gVGh1LCBNYXIgMDIsIDIwMjMgYXQgMDY6NDA6MjlQTSAr
MDAwMCwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+Pj4+Pg0KPiA+Pj4+Pj4gRnJvbTogTWljaGFl
bCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gPj4+Pj4+IFNlbnQ6IFRodXJzZGF5LCBN
YXJjaCAyLCAyMDIzIDg6MDUgQU0NCj4gPj4+Pj4NCj4gPj4+Pj4+ICtXaGVuIFxmaWVsZHtzdGF0
dXN9IGlzIFZJUlRJT19BRE1JTl9TVEFUVVNfT0ssDQo+ID4+Pj4+PiArXGZpZWxke3N0YXR1c19x
aWFsaWZpZXJ9IGlzIHJlc2VydmVkIGFuZCBzZXQgdG8gemVybyBieSB0aGUgZGV2aWNlLg0KPiA+
Pj4+Pj4gKw0KPiA+Pj4+PiBzL3N0YXR1c19xaWFsaWZpZXIvc3RhdHVzX3F1YWxpZmllcg0KPiA+
Pj4+PiBNaXNzZWQgZnJvbSB2MTAgb2YgRmViLg0KPiA+Pj4+Pg0KPiA+Pj4+Pj4gK1doZW4gXGZp
ZWxke3N0YXR1c30gaXMgVklSVElPX0FETUlOX1NUQVRVU19FSU5WQUwsIHRoZSBmb2xsb3dpbmcN
Cj4gPj4+Pj4+ICt0YWJsZSBkZXNjcmliZXMgcG9zc2libGUgXGZpZWxke3N0YXR1c19xaWFsaWZp
ZXJ9IHZhbHVlczoNCj4gPj4+Pj4gcy9zdGF0dXNfcWlhbGlmaWVyL3N0YXR1c19xdWFsaWZpZXIN
Cj4gPj4+Pj4NCj4gPj4+Pj4gQ2FuIHlvdSBwbGVhc2UgYWRkIG90aGVyIHVzZWZ1bCBlcnJvciBj
b2RlcyBpbiBhZGRpdGlvbiB0byB0aGUgRUlOVkFMPw0KPiA+Pj4+PiBGZXcgdGhhdCB3ZSBhcmUg
bmVlZGVkIEVBR0FJTiwgRU5PTUVNLCBFQlVTWSwgRU5PREVWLg0KPiA+Pj4+DQo+ID4+Pj4gUGxl
YXNlIGRlZmluZSBhIHVuaXF1ZSBjb25zdGFudCBmb3IgZWFjaCBlcnJvciBjb25kaXRpb24gdGhh
dCBjYW4NCj4gPj4+PiBvY2N1ciBpbnN0ZWFkIG9mIHNoYXJpbmcgY2F0Y2gtYWxsIGVycm5vIGNv
bnN0YW50cyBiZXR3ZWVuIG11bHRpcGxlDQo+ID4+Pj4gZXJyb3IgY29uZGl0aW9ucy4gSWYgYSBk
cml2ZXIgd2FudHMgdG8gc3F1YXNoIHRoZW0gdG9nZXRoZXIgaW50byBhbg0KPiA+Pj4+IGVycm5v
LCB0aGF0J3MgZmluZSwgYnV0IEkgdGhpbmsgZG9pbmcgdGhpcyBhdCB0aGUgaGFyZHdhcmUNCj4g
Pj4+PiBpbnRlcmZhY2UgbGV2ZWwgaXMganVzdCBwcm9wYWdhdGluZyB0aGUgbWlzdGFrZXMgb2Yg
ZXJybm9zLg0KPiA+Pj4+DQo+ID4+Pj4gT25seSBzdGF0dXNfcXVhbGlmaWVyIGlzIG5lZWRlZCBh
bmQgdGhlIHZhZ3VlIHN0YXR1cyBmaWVsZCBjYW4gYmUNCj4gPj4+PiBkcm9wcGVkLiBJdCdzIG5v
dCBjbGVhciB0byBtZSB3aHkgYWRkaW5nIEVBR0FJTiwgRU5PTUVNLCBFQlVTWSwgYW5kDQo+ID4+
Pj4gRU5PREVWIGlzIHVzZWZ1bC4gVGhleSBoYXZlIG5vIG1lYW5pbmcgdG8gdGhlIGRyaXZlciwg
b25seSB0aGUNCj4gPj4+PiBzdGF0dXNfcXVhbGlmaWVyIHJlYWxseSBpbmRpY2F0ZXMgd2hhdCBp
cyBnb2luZyBvbi4NCj4gPj4+DQo+ID4+PiBBdCBhIGhpZ2ggbGV2ZWwgYXQgdGhlIG1vbWVudCB3
ZSBoYXZlIG9ubHkgdHdvIGNhc2VzOg0KPiA+Pj4gLSBvaw0KPiA+Pj4gLSBpbnZhbGlkIGlucHV0
IHN1cHBsaWVkIGJ5IGRyaXZlcg0KPiA+Pj4NCj4gPj4+IG1heWJlIHdlIHdpbGwgaGF2ZSBtb3Jl
IHJlYXNvbnMgZm9yIGEgZmFpbHVyZSAtIHJlbWFpbnMgdG8gYmUgc2Vlbi4NCj4gPj4+DQo+ID4+
Pg0KPiA+Pj4NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4+DQo+ID4+Pj4gSSdtIHN1cmUgeW91IGd1eXMg
aGF2ZSBkaXNjdXNzZWQgdGhpcyBwcmV2aW91c2x5LCBidXQgcGxlYXNlIHByb3ZpZGUNCj4gPj4+
PiByYXRpb25hbGUgaW4gdGhlIHNwZWMgYmVjYXVzZSBpdCBsb29rcyB3ZWlyZCB0byBzb21lb25l
IHdpdGggZnJlc2ggZXllcy4NCj4gPj4+Pg0KPiA+Pj4+IFN0ZWZhbg0KPiA+Pj4NCj4gPj4+IFJl
YWxseSBtb3N0IGRyaXZlcnMganVzdCB3YW50IHRvIHByb3BhZ2F0ZSBlcnJubyB0byB1c2Vyc3Bh
Y2UuDQo+ID4+PiBBbGwgdGhlIGRldGFpbGVkIHJlcG9ydGluZyBpcyBmb3Igc3VyZSB3ZWxsIGlu
dGVudGlvbmFsIGJ1dA0KPiA+Pj4gaW4gdGhlIGVuZCBpdCBpcyBhdCBiZXN0IHByaW50ZWQgaW50
byBsb2cgLSBlbmQgdG8gZW5kDQo+ID4+PiBwZW9wbGUganVzdCBlbmQgdXAgd2l0aCBhIHN3aXRj
aCBzdGF0ZW1lbnQNCj4gPj4+IGNvbnZlcnRpbmcgdGhlc2UgdG8gZXJybm8gY29kZXMuDQo+ID4+
PiBTbyB3ZSBhcmUgcGFzc2luZyB0aGVtIGZyb20gZGV2aWNlIGFuZCB0aGlzIHdheSB0aGVyZSB3
aWxsIGJlDQo+ID4+PiBzb21lIHVuaWZvcm1pdHkuDQo+ID4+DQo+ID4+IFBsZWFzZSBjbGFyaWZ5
IHRoZSByYXRpb25hbGUgaW4gdGhlIHNwZWMuIEkgZG9uJ3QgYWdyZWUgd2l0aCBpdCwgYXMNCj4g
Pj4gZXhwbGFpbmVkIGluIG15IGVhcmxpZXIgZW1haWwsIGJ1dCBhcyBsb25nIGFzIGl0cyBkb2N1
bWVudGVkLCBwZW9wbGUgY2FuDQo+ID4+IHRyeSB0byBmb2xsb3cgaXQuDQo+ID4+DQo+ID4+IFN0
ZWZhbg0KPiA+DQo+ID4gSXQncyAyOjIgZm9yIG5vdywgeW91IGFyZSB3aXRoIFBhcmF2LCBtZSBh
bmQgQ29ybmVsaWEgbGlrZSBpdCA6KQ0KPiA+IE9yIEkgd2lsbCB0cnkgdG8gZG9jdW1lbnQgaXQg
YmV0dGVyLg0KPiBJIGRvbid0IHVuZGVyc3RhbmQgdGhpcyBzdGF0dXNfcXVhbGlmaWVyIGFzIHdl
bGwgYW5kIGl0IHdhc24ndCBpbmNsdWRlZA0KPiBpbiBteSBvcmlnaW5hbCBwYXRjaCBzZXQuDQo+
IEkgdm90ZSBmb3IgInN0YXR1cyIgdGhhdCBkZXNjcmliZSBnZW5lcmljIHN0YXR1cyBjb2RlcyBh
bmQNCj4gImNvbW1hbmRfc3BlY2lmaWNfZXJyb3IiIHRoYXQgc2hvdWxkIGJlIGluc3BlY3RlZCBi
eSB0aGUgZHJpdmVyIG9ubHkgaWYNCj4gInN0YXR1cyIgaXMgc2V0IHRvICJWSVJUSU9fQURNSU5f
U1RBVFVTX0NPTU1BTkRfU1BFQ0lGSUNfRVJSIi4NCj4gV2UgZGlzY3Vzc2VkIHRoaXMgc28gbWFu
eSB0aW1lcyBiZWZvcmUgKGFuZCBhbHJlYWR5IGFncmVlZCBJSVJDKSBhbmQNCj4gYWRkaW5nIHRo
aXMgbmV3IHF1YWxpZmllcnMgbWVjaGFuaXNtIHNvdW5kcyBub3QgcmlnaHQgdG8gbWUgYW5kIG5v
dA0KPiBpbnR1aXRpdmUgZm9yIGRldmljZSBhbmQgZHJpdmVyIGRldmVsb3BlcnMuDQo+IA0KPiBJ
IHN1Z2dlc3Q6DQo+IA0KPiAxLiBWSVJUSU9fQURNSU5fU1RBVFVTX1FfSU5WQUxJRF9PUENPREUN
Cj4gMi4gVklSVElPX0FETUlOX1NUQVRVU19RX0lOVkFMSURfRklFTEQNCj4gMy4gVklSVElPX0FE
TUlOX1NUQVRVU19RX0lOVkFMSURfR1JPVVANCj4gNC4gVklSVElPX0FETUlOX1NUQVRVU19RX0lO
VkFMSURfTUVNQkVSDQo+IDUuIFZJUlRJT19BRE1JTl9TVEFUVVNfQ09NTUFORF9TUEVDSUZJQ19F
UlIgKGZvciBtb3JlIGluZm8gcmVhZCB0aGUNCj4gY29tbWFuZF9zcGVjaWZpY19lcnJvciBmaWVs
ZCkuDQoNClRoaXMgaXMgYWxzbyBhIGdvb2QgcHJvcG9zYWwgdGhhdCAzIHBvc2l0aXZlcy4NCg0K
MS4gVGVsbHMgZXhhY3RseSB3aGF0IHdhcyB3cm9uZyB3aXRoIGNvbW1hbmQgb3Igd2l0aCBkZXZp
Y2UNCjIuIGdlbmVyaWMgZW5vdWdoIHRvIGNvbnZlcnQgaW50byBhYnN0cmFjdCBPUy1zcGVjaWZp
YyBlcnJvciBjb2RlcyB3aXRoIG5lZ2xpZ2libGUgY29zdCAoc3dpdGNoLWNhc2UpDQozLiBjYW4g
ZGVmaW5lIGNvbW1hbmQtc3BlY2lmaWMgZXJyb3IgZGV0YWlscw0K

