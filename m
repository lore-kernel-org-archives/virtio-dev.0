Return-Path: <virtio-dev-return-14024-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A28CC25B48
	for <virtio-dev@archiver.kernel.org>; Thu, 26 Oct 2023 10:24:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7359426A38
	for <virtio-dev@archiver.kernel.org>; Thu, 26 Oct 2023 10:24:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6DC6C986A5D
	for <virtio-dev@archiver.kernel.org>; Thu, 26 Oct 2023 10:24:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5FA25986A5B; Thu, 26 Oct 2023 10:24:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49403986A5C;
	Thu, 26 Oct 2023 10:24:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJLBKVyhe/aL1JWsaOsHNwc2CccUyzRKcsVDhsSOAXpQlhbm+jA6cTDEITswOdo98bbunR2b9huIbC5aBVyvYtRW0VFJSiVF5soBX/ulv0zerERNIUX9vU/AFqYtoI6fmOpdUpZvI0hWezqa+GMxIzZuNfpx7b9NgixAcraLb/QBMYkdXTKjvbascQhH8NTE7b+5IkCh2cdXYFM5Sf1nxidM/oiVswenM4yNZFshzXKci2ddko3AjYCbZFLSrcXOXqc3mvIct7S1vYv6qwYNhxkDwne1FgGYYDshqLKIkA/tD65lVv546XGiwUW+68h2/PEovU31t/hcPVvSpNSydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGZ/I8cR/FFN6V174EKf+0N8MkJQgiuyn0JJS3msGzk=;
 b=hNYRKNtv+idS61BppBGmdYJP2miz3edogXmwk3ltwYe55bXTYwOfbxXxY2W3DhHNKtMejmb6WQNeKD3N5edEiq29Tr6eTNvaw3MSegqIlFiSkr/mKFzHXu+6r/+5ASI09wytNxgqXLT6DFGcaAKfi3awiGP+z7nvVHSYsMogNW5EaNU+wpjMCoIhD/cfAthgRncr19N8NyOJyYumEY/kMxHRkeUmgxbT+FPkmo/xZ+ZIrDA/whQIK6HV8PllmriCkb1syMAu/FSA/1bg9R9PIc9Nr54IVZAc/J4ELpIUvY19aIzvcksaQwxy3pEj4PBCt4z378N29tioTced5sk4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Parav Pandit <parav@nvidia.com>
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
	"Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Thread-Topic: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES
Thread-Index:
 AQHaA9HvmHelxVzMEkK9DIiJvUqDjbBW5OUAgAC5UoD//8WsgIAB4oYA//+CG4CAAI+hgIAAjVeAgAJwQAA=
Date: Thu, 26 Oct 2023 10:24:26 +0000
Message-ID:
 <BL1PR12MB58498946F163AFE8AFE7DF94E7DDA@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <20231021035111.650248-2-Jiqian.Chen@amd.com>
 <PH0PR12MB548182FF345FE7D1DE0D89C1DCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584997339FBFF8E8DF007755E7D8A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481DBD22233808AA9497ADBDCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584959DE2A88F4968ECC6740E7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481BAA4566F77FBEA8B712CDCDFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584921B4DFE8A074107904EEE7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481A43D8E5A0F580B785E1EDCDEA@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB5481A43D8E5A0F580B785E1EDCDEA@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.6933.019)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|MN2PR12MB4285:EE_
x-ms-office365-filtering-correlation-id: f34c85d0-8bbb-43bc-2bc0-08dbd60dbafa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xwY11ULDr47R+MzWlHf8/JpVNOb19N+hJL6K96tnLKoguZ2Whc/SQIMYeEFAm2GewXVTJx19UOVGt85mjhYJWW/aKInyHcHf6PwgQAA2uWbqAX+qP9qw6UlUqoZSb6hOoGgMN7v6Ua77mqtAftK4Y4pbTnBOeFMr2weJ+Avt6sdFwSb2nuWtX6UVlNGT0KNVFDeNXUFFP6vN7W6nlKWmoxQntiNF4kH/nSnRB2zdE3baGwuAGf63jfrsbDwXLBsya/KJKHpSVmhGnPbZ66g2tD3sNZqfl+CFK06++sHHR9O/VqM+3jklgf0WPaUu7Z3RWpwG7Z/a3Z7ycc9tPMc5tFSPvC2lsV3T8wNZBqpQW6KDFGoYawk1yWVzG3GgVLqvQ+W6QU4FjYLpNbCBfP/dR+sgwwS5Gm4XpClPmP+wyBjaFa4AyrrDTYLIbgScTeWoYL2ae7WHdwAimJF5dt5Vs2pq7sZTb/CzB0BfPcPr0QcHdTQeYV/sE1B4yA/MeFoBJc4Uv8CWbNWfgl1kftbETiKFJdmKnG652UZIb1CyOO8diCv4fBu95SiuGLx4ZGn3UPK0VqdEvepYRwff9qsJdx6RIKXUnUhyXrba6c6Ft85NoTM4goTs8BU8zPxF132B
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(376002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(8676002)(55016003)(122000001)(33656002)(6916009)(316002)(66946007)(54906003)(66476007)(71200400001)(66446008)(66556008)(8936002)(64756008)(38100700002)(76116006)(478600001)(7696005)(83380400001)(7416002)(2906002)(52536014)(4326008)(5660300002)(9686003)(53546011)(41300700001)(26005)(6506007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnJoUnNvMDFJRVFURDJwQ2c2REdyckUrNWw4Zzh4aGRERE5EeCtlK2J3c3Rz?=
 =?utf-8?B?OEJIOFJ5cS92TXhmcy9JY1pSZmZXcC9qNkRTeTVHZklEaHNyT2FaaWNZekR4?=
 =?utf-8?B?eWpNVmFqMWdqLzJHQnVDM2xxUmpPcWV2c1M2S3BCWTdWbWMwUDFFQm1OSHNR?=
 =?utf-8?B?bGR1bVFiV0FXUjZJekNlcGMxZXVTdWNLTDZBT1VrTjFMTmVGWFAyZlN5d2Iw?=
 =?utf-8?B?YVBhZVBEMWpWQW8vdThDRmtOTTZYS3h1d3RnQ0k5N25ocVMzTWZ2ZG1GUjJ2?=
 =?utf-8?B?VTNZN0RjaEc2TG5xMDFaRnNkeTZkTU9LdTg2TVRua0hWM3l0QVJRUU00Vk5M?=
 =?utf-8?B?T0J6TFh3NHhSb212MGdmODRtZ2tvZE96M2kyL3lkc2RhV2ZxQW10VGNHdnVM?=
 =?utf-8?B?SytPWVhTVi82djljZFFJaW5LRWlCNlcxQmZmZUdFT0Ezamc3QkNoTUxGUHQ1?=
 =?utf-8?B?b29teUFSckkwRDNRMkFnOWpCaUh0S2pjZzhRTUdFcGZKREhiUEtTeTFrTDJh?=
 =?utf-8?B?Mzl6a3QvVm1KTHg4VS9tRFNaWGpuNWhvMVFWWnBnWTBGdDhVcDVPbjYzUVZR?=
 =?utf-8?B?b0dBNTF3dFlUZ1ZSblpiZWtVa3cyZkkxNlNPUHV3dEtsaEFCZ3RaMjk1Nk9F?=
 =?utf-8?B?RFY1S1pQREZtU0RQbmtaRDZGRmozcW0wOCs2QUVZWnBVZXNuL2NEbTZheWJn?=
 =?utf-8?B?U284ZFFVR01hMkoxOVVGN3hIZFZncmU2R2tiZUNaRFJSNVZOM3BNVXIwa054?=
 =?utf-8?B?NG8rTWhUKytUOWdMYzVMV0lqQlVGSEoxT0dvUnhkZ1RUM1lwVkQrRDBtcFJ5?=
 =?utf-8?B?cGJvbUovZmdUMzFzMmkvV1ZlcnVPL1pTWGdWcURYYXNqZHZDb3ZTcUhTclZu?=
 =?utf-8?B?aFpXcWVPMXVFMXRqR0lsOFNmTFBhcHZqQXZoZ0VCMFNuMlBqcDVyT001UmZx?=
 =?utf-8?B?c0h0RmJ2S2QzUlBkYnduaXQrcnIrWnpSV1cwN3JLWTRZWTZiVmNJUUdLV1hN?=
 =?utf-8?B?YXFmV21xM2hDUFN3WmlpeW5DTTMyR3BwdnRlb3ZrdUdjd3Q0bzN5Y3JVem1x?=
 =?utf-8?B?SFhjY2lBelBjQTRKS3lYNmpYZXBRT2hqRUloR01nMEdXbW9temI5clRIZnRN?=
 =?utf-8?B?Z2Mza091ZU10NWp2LzZmak4wZUorblk3RzJxWWxyVC9DNjVSVWUxa2QwODd2?=
 =?utf-8?B?c2dzY0JWWWI1Q3pCQUY1aVp6U2xmaXRhKzhIZE4rU0FxYzNzcjh5cHA1Wlpx?=
 =?utf-8?B?MzVkV3JqNTJqcDd0SlJvMzJ4R3ZZaGlCU2ZwVHlpay95RDlzTXZZYVRhek1u?=
 =?utf-8?B?Z3RyZFRnWXIvRFpNMjVjMlNNUDJOVXJFNkpiRVl2MXBJUjlyck5ISnVTVklG?=
 =?utf-8?B?M2dLUXM5UVZwbHJCTXM5MC80c0VzSEdSRUMwcDNyOXRxZy9zUm0vb3RHUHdT?=
 =?utf-8?B?aG54cm8rTkNxNkRaK1RsQU11bHB5K09mNU9MMmxuaktrQUJrNzc2aVU3VEND?=
 =?utf-8?B?eFhPL0l4ZHhCUFhIZ3doajF3OTMxWGs0cDBrbklDcm9KcklaSm5vcUEya0Vp?=
 =?utf-8?B?bE41RWRrYlN0S1JrKzNTZ1lubmpxeThYSTRpc0FCL3JycXMzL0p5U1VHeFVT?=
 =?utf-8?B?VEM5bVRuSjhzaE1xc05BNW5CeWN5dk9VZmZSQ2M3NWNtNHM1WndvRC9NNjlm?=
 =?utf-8?B?SkgyY1ZoTEhhOVhYMFFWU2JRSDNabnpMMnczZWVpWm9ZWEUxa0VaUDUzNzhs?=
 =?utf-8?B?TWp4ZmdIbXdQYkNQYUNsaVcxdzJHcEZ2YzR2NVViQ2U3cVZTVTdrMHBCdnVV?=
 =?utf-8?B?Q1dkNWJIWnhYNmpibWwvd2QxN2NlNU1BTEY0c3puRnd4NDV4aEVtejRWQ2tN?=
 =?utf-8?B?eDMzUzJ4WVJZSDZsaXV4ZWdNeVc5bzNWanhTVWdycjdiemFQZlMvUitqMzNM?=
 =?utf-8?B?UTVNSVlGekRWWS9aUHhyZXMvQ202TDAzWm8wZmYrL3JidDlVZUNYQjlmUXVi?=
 =?utf-8?B?NXV4N3FlQzdUZXh2cGJ1UHArOGlIbldyT3F6ZzB3S1k4dUR6dVBwWGlCeXhD?=
 =?utf-8?B?Qkp2RGU4b3VPdS9naFduL0QrR2MxU3BQYVpCVS9VOG9YRDdrdVV5VVI5aURw?=
 =?utf-8?Q?Rmvs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40F704AF694BB24682177DC621F7E96F@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34c85d0-8bbb-43bc-2bc0-08dbd60dbafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 10:24:26.2879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0m5yujP4oU3Sw0Z1dzqoZayaXAJXP9IllnoImzlPkp8zRQzGO4QpvS04Ds5m92aQbnavG/zIpyp15GwG8zFmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
Subject: [virtio-dev] Re: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

DQpPbiAyMDIzLzEwLzI1IDExOjUxLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+IA0KPiANCj4+IEZy
b206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4+IFNlbnQ6IFR1ZXNkYXks
IE9jdG9iZXIgMjQsIDIwMjMgNTo0NCBQTQ0KPj4NCj4+IE9uIDIwMjMvMTAvMjQgMTg6NTEsIFBh
cmF2IFBhbmRpdCB3cm90ZToNCj4+Pg0KPj4+PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEppcWlhbi5D
aGVuQGFtZC5jb20+DQo+Pj4+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjQsIDIwMjMgNDowNiBQ
TQ0KPj4+Pg0KPj4+PiBPbiAyMDIzLzEwLzIzIDIxOjM1LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+
Pj4+Pg0KPj4+Pj4+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4+
Pj4+PiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjMsIDIwMjMgNDowOSBQTQ0KPj4+Pj4NCj4+Pj4+
Pj4gSSB0aGluayB0aGlzIGNhbiBiZSBkb25lIHdpdGhvdXQgaW50cm9kdWNpbmcgdGhlIG5ldyBy
ZWdpc3Rlci4NCj4+Pj4+Pj4gQ2FuIHlvdSBwbGVhc2UgY2hlY2sgaWYgdGhlIFBNIHJlZ2lzdGVy
IGl0c2VsZiBjYW4gc2VydmUgdGhlDQo+Pj4+Pj4+IHB1cnBvc2UgaW5zdGVhZA0KPj4+Pj4+IG9m
IG5ldyB2aXJ0aW8gbGV2ZWwgcmVnaXN0ZXI/DQo+Pj4+Pj4gRG8geW91IG1lYW4gdGhlIHN5c3Rl
bSBQTSByZWdpc3Rlcj8NCj4+Pj4+IE5vLCB0aGUgZGV2aWNlJ3MgUE0gcmVnaXN0ZXIgYXQgdHJh
bnNwb3J0IGxldmVsLg0KPj4+PiBJIHRyaWVkIHRvIGZpbmQgdGhpcyByZWdpc3RlcihwY2kgbGV2
ZWwgb3IgdmlydGlvIHBjaSBsZXZlbCBvciB2aXJ0aW8NCj4+Pj4gZHJpdmVyIGxldmVsKSwgYnV0
IEkgZGlkbid0IGZpbmQgaXQgaW4gTGludXgga2VybmVsIG9yIFFlbXUgY29kZXMuDQo+Pj4+IE1h
eSBJIGtub3cgd2hpY2ggcmVnaXN0ZXIgeW91IGFyZSByZWZlcnJpbmcgdG8gc3BlY2lmaWNhbGx5
PyBPciB3aGljaA0KPj4+PiBQTSBzdGF0ZSBiaXQgeW91IG1lbnRpb25lZCBiZWxvdz8NCj4+Pj4N
Cj4+PiBQQ0kgc3BlYydzIFBDSSBQb3dlciBNYW5hZ2VtZW50IENhcGFiaWxpdHkgU3RydWN0dXJl
IGluIHNlY3Rpb24gNy41LjIuDQo+PiBZZXMsIHdoYXQgeW91IHBvaW50IHRvIGlzIFBNIGNhcGFi
aWxpdHkgZm9yIFBDSWUgZGV2aWNlLg0KPj4gQnV0IHRoZSBwcm9ibGVtIGlzIHN0aWxsIHRoYXQg
aW4gUWVtdSBjb2RlLCBpdCB3aWxsIGNoZWNrIHRoZQ0KPj4gY29uZGl0aW9uKHBjaV9idXNfaXNf
ZXhwcmVzcyBvciBwY2lfaXNfZXhwcmVzcykgb2YgYWxsIHZpcnRpby1wY2kgZGV2aWNlcyBpbg0K
Pj4gZnVuY3Rpb24gdmlydGlvX3BjaV9yZWFsaXplKCksIGlmIHRoZSB2aXJ0aW8gZGV2aWNlcyBh
cmVuJ3QgYSBQQ0llIGRldmljZSwgaXQgd2lsbCBub3QNCj4+IGFkZCBQTSBjYXBhYmlsaXR5IGZv
ciB0aGVtLg0KPiBQQ0kgUE0gY2FwYWJpbGl0eSBpcyBtdXN0IGZvciBQQ0llIGRldmljZXMuIFNv
IG1heSBiZSBRRU1VIGNvZGUgaGFzIHB1dCBpdCBvbmx5IHVuZGVyIGlzX3BjaWUgY2hlY2suDQo+
IEJ1dCBpdCBjYW4gYmUgZG9uZSBvdXRzaWRlIG9mIHRoYXQgY2hlY2sgYXMgd2VsbCBiZWNhdXNl
IHRoaXMgY2FwYWJpbGl0eSBleGlzdHMgb24gUENJIHRvbyBmb3IgbG9uZyB0aW1lIGFuZCBpdCBp
cyBiYWNrd2FyZCBjb21wYXRpYmxlLg0KRG8geW91IHN1Z2dlc3QgbWUgdG8gaW1wbGVtZW50IFBN
IGNhcGFiaWxpdHkgZm9yIHZpcnRpbyBkZXZpY2VzIGluIFFlbXUgZmlyc3RseSwgYW5kIHRoZW4g
dG8gdHJ5IGlmIHRoZSBQTSBjYXBhYmlsaXR5IGNhbiB3b3JrIGZvciB0aGlzIHNjZW5hcmlvPw0K
SWYgc28sIHdlIHdpbGwgY29tcGxpY2F0ZSBhIHNpbXBsZSBwcm9ibGVtLiBCZWNhdXNlIHRoZXJl
IGFyZSBubyBvdGhlciBuZWVkcyB0byBhZGQgUE0gY2FwYWJpbGl0eSBmb3IgdmlydGlvIGRldmlj
ZXMgZm9yIG5vdywgaWYgd2UgYWRkIGl0IGp1c3QgZm9yIHByZXNlcnZpbmcgcmVzb3VyY2VzLCBp
dCBzZWVtcyB1bm5lY2Vzc2FyeSBhbmQgdW5yZWFzb25hYmxlLiBBbmQgd2UgYXJlIG5vdCBzdXJl
IGlmIHRoZXJlIGFyZSBvdGhlciBzY2VuYXJpb3MgdGhhdCBhcmUgbm90IGR1cmluZyB0aGUgcHJv
Y2VzcyBvZiBQTSBzdGF0ZSBjaGFuZ2luZyBhbHNvIG5lZWQgdG8gcHJlc2VydmUgcmVzb3VyY2Vz
LCBpZiBoYXZlLCB0aGVuIHRoZSBQTSByZWdpc3RlciBjYW4ndCBjb3ZlciwgYnV0IHByZXNlcnZl
X3Jlc291cmNlcyByZWdpc3RlciBjYW4uDQpDYW4gSSBhZGQgc29tZSBub3RlcyBsaWtlICJJZiBQ
TSBjYXBhYmlsaXR5IGlzIGltcGxlbWVudGVkIGZvciB2aXJ0aW8gZGV2aWNlcywgaXQgbWF5IGNv
dmVyIHRoaXMgc2NlbmFyaW8sIGFuZCBpZiB0aGVyZSBhcmUgbm8gb3RoZXIgc2NlbmFyaW9zIHRo
YXQgUE0gY2FuJ3QgY292ZXIsIHRoZW4gd2UgY2FuIHJlbW92ZSB0aGlzIHJlZ2lzdGVyICIgaW4g
Y29tbWl0IG1lc3NhZ2Ugb3Igc3BlYyBkZXNjcmlwdGlvbiBhbmQgbGV0IHVzIGNvbnRpbnVlIHRv
IGFkZCBwcmVzZXJ2ZV9yZXNvdXJjZXMgcmVnaXN0ZXI/DQoNCj4gDQo+PiBBbmQgYW5vdGhlciBw
cm9ibGVtIGlzIGhvdyBhYm91dCB0aGUgTU1JTyB0cmFuc3BvcnQgZGV2aWNlcz8gU2luY2UNCj4+
IHByZXNlcnZlIHJlc291cmNlcyBpcyBuZWVkIGZvciBhbGwgdHJhbnNwb3J0IHR5cGUgZGV2aWNl
cy4NCj4+DQo+IE1NSU8gbGFja3Mgc3VjaCByaWNoIFBNIGRlZmluaXRpb25zLiBJZiBpbiBmdXR1
cmUgTU1JTyB3YW50cyB0byBzdXBwb3J0LCBpdCB3aWxsIGJlIGV4dGVuZGVkIHRvIG1hdGNoIHRv
IG90aGVyIHRyYW5zcG9ydHMgbGlrZSBQQ0kuDQo+IA0KPj4+Pj4NCj4+Pj4+PiBJIHRoaW5rIGl0
IGlzIHVucmVhc29uYWJsZSB0byBsZXQgdmlydGlvLSBkZXZpY2UgbGlzdGVuIHRoZSBQTQ0KPj4+
Pj4+IHN0YXRlIG9mIEd1ZXN0IHN5c3RlbS4NCj4+Pj4+IEd1ZXN0IGRyaXZlciBwZXJmb3JtcyBh
bnkgd29yayBvbiB0aGUgZ3Vlc3Qgc3lzdGVtcyBQTSBjYWxsYmFjaw0KPj4+Pj4gZXZlbnRzIGlu
DQo+Pj4+IHRoZSB2aXJ0aW8gZHJpdmVyLg0KPj4+PiBJIGRpZG4ndCBmaW5kIGFueSBQTSBzdGF0
ZSBjYWxsYmFjayBpbiB0aGUgdmlydGlvIGRyaXZlci4NCj4+Pj4NCj4+PiBUaGVyZSBhcmUgdmly
dGlvX3N1c3BlbmQgYW5kIHZpcnRpb19yZXN1bWUgaW4gY2FzZSBvZiBMaW51eC4NCj4+IEkgdGhp
bmsgd2hhdCB5b3Ugc2FpZCB2aXJ0aW9fc3VzcGVuZC9yZXN1bWUgaXMgZnJlZXplL3Jlc3RvcmUg
Y2FsbGJhY2sgZnJvbQ0KPj4gInN0cnVjdCB2aXJ0aW9fZHJpdmVyIiBvciBzdXNwZW5kL3Jlc3Vt
ZSBjYWxsYmFjayBmcm9tICJzdGF0aWMgY29uc3Qgc3RydWN0DQo+PiBkZXZfcG1fb3BzIHZpcnRp
b19wY2lfcG1fb3BzIi4NCj4+IEFuZCB5ZXMsIEkgYWdyZWUsIGlmIHZpcnRpbyBkZXZpY2VzIGhh
dmUgUE0gY2FwYWJpbGl0eSwgbWF5YmUgd2UgY2FuIHNldCBQTSBzdGF0ZQ0KPj4gaW4gdGhvc2Ug
Y2FsbGJhY2sgZnVuY3Rpb25zLg0KPj4NCj4+Pg0KPj4+Pj4NCj4+Pj4+PiBJdCdzIG1vcmUgc3Vp
dGFibGUgdGhhdCBlYWNoIGRldmljZSBnZXRzIG5vdGlmaWNhdGlvbnMgZnJvbSBkcml2ZXIsDQo+
Pj4+Pj4gYW5kIHRoZW4gZG8gcHJlc2VydmluZyByZXNvdXJjZXMgb3BlcmF0aW9uLg0KPj4+Pj4g
SSBhZ3JlZSB0aGF0IGVhY2ggZGV2aWNlIGdldHMgdGhlIG5vdGlmaWNhdGlvbiBmcm9tIGRyaXZl
ci4NCj4+Pj4+IFRoZSBxdWVzdGlvbiBpcywgc2hvdWxkIGl0IGJlIHZpcnRpbyBkcml2ZXIsIG9y
IGV4aXN0aW5nIHBjaSBkcml2ZXINCj4+Pj4+IHdoaWNoDQo+Pj4+IHRyYW5zaXRpb25zIHRoZSBz
dGF0ZSBmcm9tIGQwLT5kMyBhbmQgZDMtPmQwIGlzIGVub3VnaC4NCj4+Pj4gSXQgc2VlbXMgdGhl
cmUgaXNuJ3QgZXhpc3RpbmcgcGNpIGRyaXZlciB0byB0cmFuc2l0aW9ucyBkMCBvciBkMw0KPj4+
PiBzdGF0ZS4gQ291bGQgeW91IHBsZWFzZSB0ZWxsIG1lIHdoaWNoIG9uZSBpdCBpcyBzcGVjaWZp
Y2FsbHk/IEkgYW0gdmVyeSB3aWxsaW5nIHRvDQo+PiBnaXZlIGEgdHJ5Lg0KPj4+Pg0KPj4+IFZp
cnRpby1wY2kgbW9kZXJuIGRyaXZlciBvZiBMaW51eCBzaG91bGQgYmUgYWJsZSB0by4NCj4+IFll
cywgSSBrbm93LCBpdCBpcyB0aGUgVklSVElPX1BDSV9GTEFHX0lOSVRfUE1fQklULiBCdXQgc3Rp
bGwgdGhlIHR3byBwcm9ibGVtcyBJDQo+PiBzYWlkIGFib3ZlLg0KPj4NCj4gQm90aCBjYW4gYmUg
cmVzb2x2ZWQgd2l0aG91dCBzd2l0Y2hpbmcgdG8gcGNpZS4NCj4gIA0KPj4+DQo+Pj4+PiBDYW4g
eW91IHBsZWFzZSBjaGVjayB0aGF0Pw0KPj4+Pj4NCj4+Pj4+Pj4+IC0tLSBhL3RyYW5zcG9ydC1w
Y2kudGV4DQo+Pj4+Pj4+PiArKysgYi90cmFuc3BvcnQtcGNpLnRleA0KPj4+Pj4+Pj4gQEAgLTMy
NSw2ICszMjUsNyBAQCBcc3Vic3Vic2VjdGlvbntDb21tb24gY29uZmlndXJhdGlvbg0KPj4gc3Ry
dWN0dXJlDQo+Pj4+Pj4+PiBsYXlvdXR9XGxhYmVse3NlYzpWaXJ0aW8gVHJhbnNwb3J0DQo+Pj4+
Pj4+PiAgICAgICAgICAvKiBBYm91dCB0aGUgYWRtaW5pc3RyYXRpb24gdmlydHF1ZXVlLiAqLw0K
Pj4+Pj4+Pj4gICAgICAgICAgbGUxNiBhZG1pbl9xdWV1ZV9pbmRleDsgICAgICAgICAvKiByZWFk
LW9ubHkgZm9yIGRyaXZlciAqLw0KPj4+Pj4+Pj4gICAgICAgICAgbGUxNiBhZG1pbl9xdWV1ZV9u
dW07ICAgICAgICAgLyogcmVhZC1vbmx5IGZvciBkcml2ZXIgKi8NCj4+Pj4+Pj4+ICsgICAgICAg
IGxlMTYgcHJlc2VydmVfcmVzb3VyY2VzOyAgICAgICAgLyogcmVhZC13cml0ZSAqLw0KPj4+Pj4+
PiBQcmVzZXJ2aW5nIHRoZXNlIHJlc291cmNlcyBpbiB0aGUgZGV2aWNlIGltcGxlbWVudGF0aW9u
IHRha2VzDQo+Pj4+Pj4+IGZpbml0ZSBhbW91bnQNCj4+Pj4+PiBvZiB0aW1lLg0KPj4+Pj4+PiBQ
b3NzaWJseSBtb3JlIHRoYW4gNDBuc2VjICh0aW1lIG9mIFBDSWUgd3JpdGUgVExQKS4NCj4+Pj4+
Pj4gSGVuY2UgdGhpcyByZWdpc3RlciBtdXN0IGJlIGEgcG9sbGluZyByZWdpc3RlciB0byBpbmRp
Y2F0ZSB0aGF0DQo+Pj4+Pj4gcHJlc2VydmF0aW9uX2RvbmUuDQo+Pj4+Pj4+IFRoaXMgd2lsbCB0
ZWxsIHRoZSBndWVzdCB3aGVuIHRoZSBwcmVzZXJ2YXRpb24gaXMgZG9uZSwgYW5kIHdoZW4NCj4+
Pj4+Pj4gcmVzdG9yYXRpb24gaXMNCj4+Pj4+PiBkb25lLCBzbyB0aGF0IGl0IGNhbiByZXN1bWUg
dXBwZXIgbGF5ZXJzLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBQbGVhc2UgcmVmZXIgdG8gcXVldWVfcmVz
ZXQgZGVmaW5pdGlvbiB0byBsZWFybiBtb3JlIGFib3V0IHN1Y2gNCj4+Pj4+Pj4gcmVnaXN0ZXIN
Cj4+Pj4+PiBkZWZpbml0aW9uLg0KPj4+Pj4+IFRoYW5rcywgSSB3aWxsIHJlZmVyIHRvICJxdWV1
ZV9yZXNldCIuIFNvLCBJIG5lZWQgdGhyZWUgdmFsdWVzLA0KPj4+Pj4+IGRyaXZlciB3cml0ZSAx
IHRvIGxldCBkZXZpY2UgZG8gcHJlc2VydmluZyByZXNvdXJjZXMsIGRyaXZlciB3cml0ZQ0KPj4+
Pj4+IDIgdG8gbGV0IGRldmljZSBkbyByZXN0b3JpbmcgcmVzb3VyY2VzLCBkZXZpY2Ugd3JpdGUg
MCB0byB0ZWxsDQo+Pj4+Pj4gZHJpdmVyIHRoYXQgcHJlc2VydmluZyBvciByZXN0b3JpbmcgZG9u
ZSwgYW0gSSByaWdodD8NCj4+Pj4+Pg0KPj4+Pj4gUmlnaHQuDQo+Pj4+Pg0KPj4+Pj4gQW5kIGlm
IHRoZSBleGlzdGluZyBwY2llIHBtIHN0YXRlIGJpdHMgY2FuIGRvLCB3ZSBjYW4gbGV2ZXJhZ2Ug
dGhhdC4NCj4+Pj4+IElmIGl0IGNhbm5vdCBiZSB1c2VkLCBsZXRzIGFkZCB0aGF0IHJlYXNvbmlu
ZyBpbiB0aGUgY29tbWl0IGxvZyB0bw0KPj4+Pj4gZGVzY3JpYmUgdGhpcw0KPj4+PiByZWdpc3Rl
ci4NCj4+Pj4+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IExldHMgcGxlYXNlIG1ha2Ugc3VyZSB0aGF0IFBD
SWUgUE0gbGV2ZWwgcmVnaXN0ZXJzIGFyZQ0KPj4+Pj4+PiBzdWZmaWNpZW50L25vdC1zdWZmaWNp
ZW50DQo+Pj4+Pj4gdG8gZGVjaWRlIHRoZSBhZGRpdGlvbiBvZiB0aGlzIHJlZ2lzdGVyLg0KPj4+
Pj4+IEJ1dCBpZiB0aGUgZGV2aWNlIGlzIG5vdCBhIFBDSWUgZGV2aWNlLCBpdCBkb2Vzbid0IGhh
dmUgUE0NCj4+Pj4+PiBjYXBhYmlsaXR5LCB0aGVuIHRoaXMgd2lsbCBub3Qgd29yay4gQWN0dWFs
bHkgaW4gbXkgbG9jYWwNCj4+Pj4+PiBlbnZpcm9ubWVudCwgcGNpX2lzX2V4cHJlc3MoKSByZXR1
cm4gZmFsc2UgaW4gUWVtdSwgdGhleSBhcmUgbm90DQo+Pj4+Pj4gUENJZQ0KPj4+PiBkZXZpY2Uu
DQo+Pj4+PiBJdCBpcyByZWFzb25hYmxlIHRvIGFzayB0byBwbHVnIGluIGFzIFBDSWUgZGV2aWNl
IGluIDIwMjMgdG8gZ2V0IG5ldw0KPj4+Pj4gZnVuY3Rpb25hbGl0eSB0aGF0IHRvbyB5b3UgbWVu
dGlvbmVkIGEgZ3B1IGRldmljZS4g8J+Yig0KPj4+Pj4gV2hpY2ggZG9lcyBub3QgaGF2ZSB2ZXJ5
IGxvbmcgaGlzdG9yeSBvZiBhbnkgYmFja3dhcmQgY29tcGF0aWJpbGl0eS4NCj4+Pj4gRG8geW91
IHN1Z2dlc3QgbWUgdG8gYWRkIFBNIGNhcGFiaWxpdHkgZm9yIHZpcnRpby1ncHUgb3IgY2hhbmdl
DQo+Pj4+IHZpcnRpby1ncHUgdG8gYSBQQ0llIGRldmljZT8NCj4+Pj4NCj4+PiBQQ0kgUG93ZXIg
TWFuYWdlbWVudCBDYXBhYmlsaXR5IFN0cnVjdHVyZSBkb2VzIG5vdCBzZWVtIHRvIGJlIGxpbWl0
ZWQgdG8NCj4+IFBDSWUuDQo+PiBJIGFtIG5vdCBzdXJlLCBidXQgaW4gY3VycmVudCBRZW11IGNv
ZGUsIEkgY2FuIHNlZSB0aGUgY2hlY2sgInBjaV9pc19leHByZXNzIg0KPj4gZm9yIGFsbCB2aXJ0
aW8tcGNpIGRldmljZXMuIElmIHdlIHdhbnQgdG8gYWRkIFBNIGNhcGFiaWxpdHkgZm9yIHZpcnRp
by1wY2kgZGV2aWNlcywNCj4+IHdlIG5lZWQgdG8gY2hhbmdlIHRoZW0gdG8gUENJZSBkZXZpY2Ug
SSB0aGluay4NCj4+DQo+IFRoYXQgaXMgb25lIG9wdGlvbi4NCj4gU2Vjb25kIG9wdGlvbiB0byBl
eHRlbmQgUENJIFBNIGNhcCBmb3Igbm9uIHBjaSBkZXZpY2UgYmVjYXVzZSBpdCBpcyBzdXBwb3J0
ZWQuDQo+IA0KPj4+DQo+Pg0KPj4gLS0NCj4+IEJlc3QgcmVnYXJkcywNCj4+IEppcWlhbiBDaGVu
Lg0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0K

