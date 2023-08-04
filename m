Return-Path: <virtio-dev-return-13470-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E604BC001DE
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 08:09:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 39A59790BC
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 08:09:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3063598680A
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 08:09:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2272A9866E2; Fri,  4 Aug 2023 08:09:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 07ED19866DF;
	Fri,  4 Aug 2023 08:09:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVEq6RFNQgCt/2ADb9oWz1at78VtnoL4J400x3hzvi6ldhEXIc+hxedNvOldX++a4+OGRXl5FL7TroVCqVMr+f7QA0yhiomIAKOuN8yC7ZGcG0q2Nx35el3g1nDbDin2TVqnV0xWleIfB0vTE1eQPHw+RcIp4IVXhIan/d8H/WNQoqd9dQwTJ4cjY4/XWZDfjv7WmDHviVmXujIl+00iIqHJA3wVO/32w9TZ3AhGbwWvNE+55H5jqb48mUlRRRf98OzRtxnkvvvdQf2l5p0Na2hKGEr9zuUOPAS/swC/anGdseAMa05RqpHFlibp0mpesOAF5RgVWVR/gbJOkCkoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnIkjJpsj3/NMG24RRvJr+y/kF2A7MtJ1GPkmvZWjo8=;
 b=TA2il/SxmIb0batuO/Nsh5ypxY1xpqYLQ1OHaqrbboPx7AnvgezBLotuJba2rD0YiXDPxu4PhBNu5FNbIP82eQspGT69FQeaUJdlphKlHS/ruSdw76duywCMCDrK9mbtccT3gefa88BnNNiUHGOefI4Isikc1yZ3K+s4ebWaRKxMtXn7+nzIyBBJhrdDAriofqoyKNh1jyO9J2vQ9JOvtdM79v7YbehH/NnzuF7EI8K9+bQedDC+sTQiY2ihSrW9mTiAFXIirhXxIb1iQA5do4Oxcs0b7kQpLpRCNFfZKNgK3fSX2uFu0dKdTsvcp/8+fYiQQvRJKw94qumJxCuP7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Parav Pandit <parav@nvidia.com>, Robert Beckett
	<bob.beckett@collabora.com>, Gerd Hoffmann <kraxel@redhat.com>
CC: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
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
Thread-Index:
 AQHZuwRh6691cWFD3EGobeyAVCVbhK/W7j4A//+VJgCAAI+1gP//mKMAgACymgCAAXrwAIAA8liAgACKxIA=
Date: Fri, 4 Aug 2023 08:09:45 +0000
Message-ID:
 <BL1PR12MB5849551B2B7A898C99B4CA8AE709A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20230720121844.8956-1-Jiqian.Chen@amd.com>
 <BL1PR12MB5849C19607B02CDA76BD9F61E70BA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481C2248C74E551B3318DD8DC0BA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849A2599DD46405262B8630E70BA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB54819BEBB889ACF23324B69EDC0BA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849EC8E7EE93D76AEB7030BE708A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <7afaefa6-2734-b3d9-d728-a06f5ad2df63@collabora.com>
 <PH0PR12MB5481D29B65853913101593E8DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB5481D29B65853913101593E8DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: IA1PR12MB6331.namprd12.prod.outlook.com
 (15.20.6652.008)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|CH3PR12MB7737:EE_
x-ms-office365-filtering-correlation-id: 03600bf0-9af6-4889-ebf1-08db94c22a54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MAv00PQfw5BBtduBlxe/Fl8IUZCXCzkXNYn0avsU64F1IAN2J2Fm61c9IsjwCkI0Ggh3L19XOs5WzPqgjWtS4wZyOh5UDC08sP6kI+g4t37uUxB/xi6UDniwKEyAlB5gX6c7OeQ4m+ilfGVkcL6ui93is3nGTEVsAZZfVnQ1W4Wn61sip1UWdiqkDma3v79r0fjz+wKP5srASkrm8vt4Nb/IFkEC/UHyIA7yiAjL7lh6QuqD7kuje6V6FUvPpdG76A/i+/BEGY9XjP+35l+/wAmJ0nWn5x+dUZY05OHRGFC7dhJVxFOd3vZtSDNfLFuMLM6lq1Zc4ITN0BVWT+mRLMq09MQuHv5YdwUWeiQGxHUB0kwzyhpgAQx/Nf6QWSpCpMBAoJTazK0mMJWRqDFefIgrKRGXlFA5xOCw6BOEIG9akj74gcgf0CfgEzvI2cxBHMMQdm+L+2NcWdKK8fzR1ZUeFW+HH8ZNuMtY3xnyrNVXJITTMGAuT+HCmwl16Vti1a9H346CZc15gqQtVFAqupjm0WfKgbISBHIlvNXrUJLB8sEUji2R0wwwFCcjedb2Bn1wU1qoa0LcNaRuzj44CJLNgqY2ApPqTmZA9kchqnkSht70cZ93GF5oUtq0K9tu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(1800799003)(451199021)(186006)(53546011)(8676002)(26005)(6506007)(83380400001)(66476007)(2906002)(316002)(76116006)(4326008)(66946007)(5660300002)(66446008)(64756008)(66556008)(8936002)(41300700001)(7696005)(71200400001)(52536014)(9686003)(110136005)(478600001)(54906003)(55016003)(38100700002)(122000001)(33656002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXFRK1ZpWHdWdnlkb0ZxU0dvYnlQSWxHZzZNLytzbUlvQXBYV3VqdzVscDFx?=
 =?utf-8?B?ZFFLZDI4bnNZMGVUajBjRC9MQ1o5cG1rVGdjMFlTSnppSVY2RitRTVc2SEQ5?=
 =?utf-8?B?bVJzdXNKSGxoZkJNSDJ6S3ZkS05aU0VNeXpRblZlVDFFUmVXTmc5K3JJd0hs?=
 =?utf-8?B?c2JtZWluZ0Y2aWtnT0ZhZ1dmV2JYWUpNSWM1SjVvTjQvT3JkT3FHQWZxYjNN?=
 =?utf-8?B?cUQ0WnF2c09PdmxhaXJhaGxTL1lMWGdnbUhwU0JXZDRWNXFEa243UTZOTHpj?=
 =?utf-8?B?MmJzR1ZYMDJCbDhVck9kSHVySDJFbWVmQ1JGVUJUaCs3dTRBYlJQRy9pMGhw?=
 =?utf-8?B?dWNmbmVQTGgzQU0xUWJFMUlQVlUyT1J6NGsxSXIycjZlY3kxRExjRXJzN2Mr?=
 =?utf-8?B?clBQMUtHbGhHSUxDcDE2ZjVFRFZIQ0NYeUcrK2dMU1pxaEJQSVh3dldpeGxq?=
 =?utf-8?B?dFcwdGtidXFBWlRsWDJoajVGMWxWdzZ0TUthcE1RejlDNXdVOWRaOTFmYll0?=
 =?utf-8?B?VGFiUXJYbXVzbFFNMzZRS1ArdXdCekxVWkthTFlkNHovOFRIdFZTT1pIMjNz?=
 =?utf-8?B?LzVkcmhEM0tVNFVXeDdtUWlmWHlNYlRsK0hQRGxSUlZ5MUlrOCtvTEpZV2kv?=
 =?utf-8?B?cU1MWThpRU9uVEROT3ZTWGZwdDhJVTh1dVMwdDNlVTJBZHVDRlJzZ0k1L0dD?=
 =?utf-8?B?NnVxMHp0T2tSR2tpd0tKcncrZUZrTXhkZmhiMUc1a1RUbEJyUWxwV3gyZEJy?=
 =?utf-8?B?c3hqVnRWMXh3NjlYd0c2WHB2K0NQYlVRSE1wdDdSaFV6MHBFN2ZxVUEwbW8w?=
 =?utf-8?B?azFuS1ZlcmlVQVI1N0tZN3l6cTdDMzJQZkQ5WDRFNVo3cjEwRVRSbG4yQ0F2?=
 =?utf-8?B?SXJuWTRxdUJHRUN6RkNPZGhlU2RBeGtlQVRMayt1aGkrWnBMbjBnbnFBSzcx?=
 =?utf-8?B?eXB6Vm9KTHoyaHk5NG4rbnlsalZqWW5MRjF2ckxlQ0p2dXdVb05OSUsvZU5U?=
 =?utf-8?B?YXNDbkxaVDVEZEw3U1c0ZHVvZGpEQkhWSVZpNWVIUmh2M3FXR0R3NTU4Qjlj?=
 =?utf-8?B?eXllSGJ0THdZTHBaQ295dG5BU2R3RWFiT2dmYlhFaEc4Q1grb0R5SWNZVTVH?=
 =?utf-8?B?bnU3dGl6OWlwVnEwc0FHcHBYL2NEcFQ2eFJTSmJVN1FiQWkxMzlmdmdCS3lH?=
 =?utf-8?B?ZlBHYUpMNi9YS2tXSFo0TmlyMnN0UW4xcGVwNjM1Rkw1M1MxS2dtTmpQZEx3?=
 =?utf-8?B?QVBMUW8wNHRQRGRkdEViMW84VjhaZ2pUMXNRc291czViTmJ6MzlOWEJ2YkZL?=
 =?utf-8?B?cVUwWnRIMndrWkpsOUFDRDhPbEZuOFJtaU85RG5YQXhnbzl5Nm1SaEpLMVgr?=
 =?utf-8?B?eHUzWkFTY3AxVzljR1pIeEgwaTFrRlkwbDJ1L1FhZjJZc0xRU0lOeWdWREVR?=
 =?utf-8?B?Sk1mdmM2TUl4S2l5Z0JiQlQveHZCbFk3N0ZSODBiUEV2MS9ERjNoUzVzbDJj?=
 =?utf-8?B?NjdyYXoyVnErUjc0RmZlSW5wdXlFNnhiK0NBR3dFakhhOUducWRDb2h0SWsz?=
 =?utf-8?B?ODd5Q2JzVDNTK2o1Q3REVmhSQzNQNG94T0dWa1Q4dzVNcEVSdnNWTUhndGo0?=
 =?utf-8?B?VkxzNjFlUGNleXU4a1Y1SnlDL2ZnSk4xVlJBYzRlY1hRNE9paW1QclBEd1JP?=
 =?utf-8?B?VWhuelExWisvdDlua0R3WEZjR2RkcHM2ZlRTK2VvTkI5blJHalhsMnZmWEdW?=
 =?utf-8?B?VTF1RXVsQWptYngzbnd2Z3ZjTUhveGczMXgvRXc1SGJ1citjVnMvcVRPdTZR?=
 =?utf-8?B?R0tmVlFKZlRidlE1YnZJQlJXSWlYMFZnYlRVZjhyVFJGM2RZTGZ6aTVBeFVU?=
 =?utf-8?B?OFBkZE54U1V5eUZuYjFtbDlFUVN1UG9UVFFkVE9YcUZ6TzJFWEcwUkQrNFk2?=
 =?utf-8?B?b0lhcVhHYTZranFsMUpGSTdENUpkcDZUUXkzSTFuTDlEUnJ1NDRFYVZHbCtp?=
 =?utf-8?B?dFFUZ3IrdHlwekxnVlNrSk5QZGhzZ1lGRXFDdVNGSFpzUmVJbUtKd0hJSjds?=
 =?utf-8?B?cXU2bWFKQlRmajRDaGlDQ0JrdEJIdmF4ZVdyUHZLT0JNRTFJcXFSUFVjSUZT?=
 =?utf-8?Q?1upM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A4E070186263E4491EE514C98C37A27@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03600bf0-9af6-4889-ebf1-08db94c22a54
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 08:09:45.7446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NQhx+clV+dsdDLI3JAW5EtBkz/ThVwVJrrcF7Wp1YGLNUx8SGAf9KwyypoB2pbJBoQKpZsW0jQQpu1qTHwnEkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7737
Subject: [virtio-dev] Re: [VIRTIO GPU PATCH v3 0/1] Add new feature flag
 VIRTIO_GPU_F_FREEZE_S3

SGksDQoNCk9uIDIwMjMvOC80IDE0OjU2LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+IA0KPiANCj4+
IEZyb206IFJvYmVydCBCZWNrZXR0IDxib2IuYmVja2V0dEBjb2xsYWJvcmEuY29tPg0KPj4gU2Vu
dDogVGh1cnNkYXksIEF1Z3VzdCAzLCAyMDIzIDk6NTkgUE0NCj4gDQo+IFsuLl0NCj4gDQo+Pj4g
SSB0aGluayB0aGVyZSBpcyBubyBuZWVkIHRvIGltcHJvdmUgdG8gcGNpIGxldmVsLiBCZWNhdXNl
IHRoaXMgZmVhdHVyZQ0KPj4+IGlzIGEgY29tcHJvbWlzZSBzb2x1dGlvbiwgaWYgcmVzb3VyY2Vz
IGFyZSBkZXN0cm95ZWQgb24gcWVtdSBzaWRlLA0KPj4+IGd1ZXN0IGhhcyBub3QgZW5vdWdoIGRh
dGEgdG8gcmUtY3JlYXRlIHRoZW0sIHNvIHdlIGNob29zZSB0byBrZWVwIHRoZW0NCj4+IHdoZW4g
c3VzcGVuc2lvbi4gVGhhdCBpcyBhIHZpcnRpby1ncHUgc3BlY2lmaWMgc2NlbmFyaW8uDQo+Pj4N
Cj4+PiBXaGF0J3MgeW91ciBvcGluaW9uLCBHZXJkIEhvZmZtYW5uLCBhbmQgUm9iZXJ0IEJlY2tl
dHQ/IEFtIEkgcmlnaHQ/DQo+Pg0KPj4gSSB0aGluayBQYXJhdiBhc2tzIGEgZ29vZCBxdWVzdGlv
bi4NCj4+DQo+PiBXaGlsZSB0aGUgaW5pdGlhbCByYXRpb25hbGUgZm9yIGRvaW5nIHRoaXMgd29y
ayBpcyB2aXJ0aW8tZ3B1IHNwZWNpZmljLCB0aGUgcG90ZW50aWFsDQo+PiBpbXBsZW1lbnRhdGlv
biBvZiBhIHNvbHV0aW9uIG5lZWQgbm90IHJlbWFpbiBncHUgc3BlY2lmaWMuDQo+PiBJZiB3ZSB3
YW50IHRvIGdlbmVyaWNpc2UgdGhlIHNvbHV0aW9uLCB0aGVuIHRoZW4gcXVlc3Rpb24gYmVjb21l
cyBhdCB3aGF0IGxldmVsDQo+PiBzaG91bGQgaXQgYmUgZG9uZT8NCj4+DQo+PiBSZWFkaW5nIHNl
Y3Rpb24gNC4xLjQuMyBvZiB0aGUgdjEuMiBzcGVjLCBpdCBsb29rcyBsaWtlIHdyaXRpbmcgMCB0
byBkZXZpY2Vfc3RhdHVzDQo+PiBhcyBleHBvc2VkIHZpYSBhbiBNTUlPIEJBUiBpcyB0aGUgUENJ
IHRyYW5zcG9ydCByZXNldCBtZXRob2QuDQo+PiBXZSBjb3VsZCBhZGQgYSBuZXcgZGV2aWNlX3N0
YXR1cyB2YWx1ZS4NCj4+IGRldmljZV9zdGF0dXMgc2hvdWxkIGJlIGV4cG9zZWQgaW4gYWxsIHRy
YW5zcG9ydCBtZXRob2RzLCBzbyB3ZSBjb3VsZCB1cGRhdGUNCj4+IHRoZSBzcGVjIHNlY3Rpb24g
Mi4xIHRvIHNheQ0KPj4NCj4+DQo+PiBEUklWRVJfU1VTUEVORCAoNSkNCj4+DQo+PiBPciBzb21l
dGhpbmcgc2ltaWxhci4NCj4+DQo+PiBBbHRlcm5hdGl2ZWx5IGEgbmV3IGRyaXZlcl9wYXJhbSBy
ZWdpc3RlciBjb3VsZCBiZSBleHBvc2VkIHRoYXQgY291bGQgaW5kaWNhdGUNCj4+IHN1c3BlbmQg
KGFuZCBhbnkgZnV0dXJlIG90aGVyIHBhcmFtZXRlcnMgdG8gc3RhdHVzIGNoYW5nZXMpLg0KPj4N
Cj4+DQo+PiBJIGd1ZXNzIGl0IGRlcGVuZHMgaG93IHNpZ25pZmljYW50IGEgY2hhbmdlIHdlIHdh
bnQgdG8gdXNlIHRvIHN1cHBvcnQNCj4+IHRoaXMgYW5kIGhvdyB1c2VmdWwgdGhlIGFyZSBwcmVk
aWN0ZWQgdG8gYmUgaW4gZnV0dXJlLg0KPj4gQXJlIG90aGVyIHBlb3BsZSBhd2FyZSBvZiBhbnkg
b3RoZXIgZGVzaXJlZCBwYXJhbWV0ZXJpc2F0aW9uIG9mDQo+PiBkZXZpY2Vfc3RhdHVzIHVwZGF0
ZXM/DQo+Pg0KPiBTb21lIG9mIHRoZSBzdGF0ZWxlc3MgZGV2aWNlcyBtYXkgYmUganVzdCBmaW5l
IHRvIGRlc3Ryb3kgYW5kIHJlY3JlYXRlIHRoZSByZXNvdXJjZXMgaW4gdGhlIFBDSSdzIGRyaXZl
cidzIGNhbGxiYWNrIG9mIHN1c3BlbmQoKSBhbmQgcmVzdW1lKCkuDQo+IA0KPiBBbmQgRFJJVkVS
X1NVU1BFTkQgbWF5IG5vdCBiZSBldmVuIG5lZWRlZC4NCj4gDQo+IFNvbWUgc3RhdGVmdWwgZGV2
aWNlIG1heSBuZWVkIHRvIHJlc3VtZSBmcm9tIHRoZSBzYW1lIHBsYWNlIHdoZXJlIGl0IGxlZnQg
b2ZmLg0KPiBJIGRvIG5vdCBrbm93IGFib3V0IGdwdSBlbm91Z2guLg0KWWVzLCB3ZSB3YW50IGFm
dGVyIHJlc3VtaW5nLCB0aGUgZGlzcGxheSBhbmQgYXBwbGljYXRpb25zIG9mIGd1ZXN0IHdpbGwg
cmVzdG9yZSB0aGUgc3RhdGUgd2hlbiBndWVzdCBhcmUgc3VzcGVuZGVkLg0KDQo+IA0KPiBNeSBx
dWVzdGlvbiBpczogaW4gdGhlIHZpcnRpbyBncHUgZHJpdmVyLCBjYW4geW91IHVzZSBQQ0kncyBz
dXNwZW5kKCkgYW5kIHJlc3VtZSgpIGNhbGxiYWNrcyB0byBkZXN0cm95IGFuZCByZWNyZWF0ZSB0
aGUgbmVlZGVkIHJlc291cmNlcz8NCj4gVGhpcyB3YXksIGd1ZXN0IGRyaXZlciBoYW5kbGVzIHdo
YXQgaXQgbmVlZHMgdG8sIGZsb3cgaXMgYWxzbyBzeW1tZXRyaWMuDQo+IEZyb20gUUVNVSBwb2lu
dCBvZiB2aWV3LCBpdHMgZHJpdmVyIHJlaW5pdGlhbGl6aW5nLCBzbyBRRU1VIHNob3VsZCBiZSBq
dXN0IGZpbmUuIChub3QganVzdCBkZXN0cm95IHRoaW5ncykNCj4gV2h5IHdvdWxkbuKAmXQgaXQg
d29yaz8gV2lsbCBpdCBiZSBzbG93IG9yPw0KPiBIYXZlIHlvdSBleHBsb3JlZCB0aGlzIHJvdXRl
Pw0KVW5kZXJzdGFuZC4gWW91ciBxdWVzdGlvbnMgaGF2ZSBiZWVuIGRpc2N1c3NlZCBpbiB0aGUg
UWVtdSBtYWlsaW5nIHRocmVhZC4gDQpUaGUgcG9pbnQgaXMgbm90IHdoZXJlIHRvIGRlc3Ryb3kg
dGhlIHJlc291cmNlcywgaXQgaXMgaG93IHRvIHJlLWNyZWF0ZSByZXNvdXJjZXMuDQpCdXQgaW4g
Y3VycmVudCBjb2RlcywgdGhlIGd1ZXN0IHZpcnRpby1ncHUgZHJpdmVyIHdvdWxkbid0IGhhdmUg
YW55IG9mIHRoZSBwaXhlbCBkYXRhIHRvIHRyYW5zZmVyIHRvIGhvc3QgYWZ0ZXIgcmVzdW1lLiBB
bmQgTWVzYSBvZnRlbiB3aWxsIGRlY2lkZSB0aGF0IGl0IHdvbid0IG5lZWQgdG8gYWNjZXNzIGEg
cmVzb3VyY2UgYWdhaW4gYWZ0ZXIgaW5pdGlhbCB1cGxvYWQuDQpTbywgZm9yIGd1ZXN0IGRyaXZl
ciwgaXQgaXMgbm90IGFibGUgdG8gcmVwcm9kdWNlIHRoZSByZXNvdXJjZXMgaW5jbHVkaW5nIHBp
eGVsIGRhdGEgb3IgZ2wgcmVuZGVyaW5nLg0KQmFzZWQgb24gdGhlIGFib3ZlIHJlYXNvbnMsIEdl
cmQgYW5kIEJvYiBhZ3JlZSB0byByZXRhaW4gcmVzb3VyY2VzIGFuZCBzdWdnZXN0IGFkZGluZyBh
IG5ldyBmZWF0dXJlIGZsYWcuDQoNCj4gDQo+IEZvciBleGFtcGxlLCByYWRlb24zMDAgZ3B1IHNl
ZW1zIHRvIHJlc2V0IHRoZSBkZXZpY2UgZHVyaW5nIHJlc3VtaW5nIGFuZCBzZWVtcyB0byBiZSBm
aW5lIHdpdGhvdXQgcGVyc2lzdGluZy4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4gQ2hl
bi4NCg==

