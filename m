Return-Path: <virtio-dev-return-13724-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEABCCA0ECA
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 13:36:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 24AB670785
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 13:36:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F77F986650
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 13:36:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 13CAE986499; Tue, 12 Sep 2023 13:36:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 022659864A4;
	Tue, 12 Sep 2023 13:36:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVKKCjaC6sO1/nedzqlxtf1LpKVRH4LAqaIzsGUFkExsrbPYJ0nhKthOKZop4k/HPd62S4IzXYeRqTRhOhOlZ+7/w30X9bydvjpJhnGociNUIPPdAlhkbR8Bd+lbn3gzlQ5XIwXHSAPUhbsMw9yiYPXWhuSRI2D0EErmMGuRw0dr4eVsngQIWDJJ6R2htjv5EKdSypmURYL8Epzxry4oJUqihDh/pk4qupt+7zboG6ULXbQhGql/82G9p39zBMHCqLyxfLxGefF80YqBN5ydo8+7LWOfV6rf/q10mNB/NKCCL3ntoMyBqtoyUGZIlQE+GyWQg38QJkpdRaXEAsy+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nK7GWy++Ly5ogOm73azs6bXmH2UGKNJGlSW5CoIUfs=;
 b=bl04705kG4WRaNiloR/qMj85oi95updQCNFdGslpO1PPH4Fb3MKQmASAlCmy5i3z0vnnD6k76uPA/4c7zMM7sz1bHvwh+Gtgdsn61XMKYwOYLGCcFu0V7b0uOi6Zx1Xf1ZdIPXsb63UDOOejWQ6KFRrY8A8Ra5ocnE1QOoEQ4RZOKmuqNZOLnWFqQTwEGkA08933YliL7JUcAcguvSq6fsM28ecuwUeeVtPoOLLLLdAwWunVSzn8JA1rlkRuD5ZsRgmOAsjxe/sopARyu6EAca4VR/2BU7zM+kFaMCTtMMBMzIvoEuXe/AgdrEg+LcbjwUiFTAbIhsN7dJptchlpCg==
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
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAFrJICAAB38cIAACoIAgAAB5TCAAAzeAIAAAVowgAAud4CAAABSIIAAAeaAgAABfOCAACmSgIAABu0A
Date: Tue, 12 Sep 2023 13:35:57 +0000
Message-ID:
 <PH0PR12MB5481E0C8D74DD3479331E0ACDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
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
In-Reply-To: <b0ae1197-f9e9-4596-f9bf-559f6112458f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN2PR12MB4358:EE_
x-ms-office365-filtering-correlation-id: f7393eea-2dd8-413d-84de-08dbb3953207
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 C8NjVed6DWSLOEF1QStRQkkgiTa9cvfev6gyKTTvUMspeEF4g6mjfik9fIqGaP86yRIY+F1dx9SQJmXyJRjr+54eKzJomY39oAXXFqyEfjxgsdYExyx8C+j/7GFLw5sGnLgSTtZnM+3k5F7z5C2PPwVJZX+YfTWZem1awMwBnmDocWtLKos48TydpMWhOF27V6vw7Xtp6z4njWARhpwGts7pKNopb4pS+mw9h1o3Jrm7IRfBlv+tjgp6ImHBJybIlpLtOYbLu9M4D9iDogp44K2KUyUsG4LWDL9eHA8ATbhUh8o3wb7+TOdBKlhQy51w8Bvxe91r0FuQZitwDnGNv9r2YjzcyrCLt/ckjUw4LMr+EYVnSeGKlkPg4YGlCPjj4h9IqHVtcVTTqacemBIB051DaIjZkiITYCGthrqaP7q931vaQIzTkBXCT55KA6AsbOwxFrRWKohs9Sl8flKVc43kxRablAinIM+HLcK55Yb+XNz9eJfKuHNJNsoRWnr3Q6mehVy2u9nc0ZwT52G6Eola6ocvKOJc3Vv59G1OPUTnBAMmJoVCi6ra7DvhfAu0bCQpSUFSJJo/gEuyGePgIVvrStlkeuqed2lWKSHMZH56Tr5qK1p57OAhQr8qrT5HP+hpGYSTE6Ds7Fl7DP+r8A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(1800799009)(451199024)(186009)(76116006)(110136005)(86362001)(2906002)(55016003)(83380400001)(7696005)(53546011)(71200400001)(6506007)(26005)(33656002)(38100700002)(9686003)(122000001)(966005)(478600001)(38070700005)(52536014)(5660300002)(8676002)(8936002)(66556008)(66476007)(4326008)(64756008)(54906003)(66446008)(316002)(66946007)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q01OMTNJalpWRnNyMkttUzZGN3MySmhObDd4YldibEhEdWVZNDRCdGtpWjdh?=
 =?utf-8?B?WC83Wk5qM01heWhhV1Nsa2J4SG1DYjlJVXpYenhqckExMWQxVGh6cnRLRWVu?=
 =?utf-8?B?NjNPbmFscHEzVXRLak55cFI1V3AvcExuOGo0ZmZEa3BsSnlGU3pLY1NmZys5?=
 =?utf-8?B?SWFqdlZkQlVaZklVYnRGL1AzY1U5Y1h3emlRN0pCamYzRnVLS0ZIRGFvRkpz?=
 =?utf-8?B?d3k0bWs4c1RmWTBHK3grWTRXNE16NXZPcXpjcWlmU2Ixak5yWHM0RGF2Mkd1?=
 =?utf-8?B?dTJLa1p1NVNqMk9LZ1BYdXFsOHBvSFdsN0NLQnhEK1FBZk9ONlM0TDRZQ1dT?=
 =?utf-8?B?MXBpNkVITHpXVUhCSHc2RzZUaEd4QTYwb0k3RVRGcVlPUkQ1VEtEeDc0anVJ?=
 =?utf-8?B?UGZKVms3aVlJdE5acC9HbzFuUEZ4ZkFnVWptTTRac2hoSXR6Rmp3YmZaMEVE?=
 =?utf-8?B?b3NPNjdQMGpPbk5KclhNUkxlaTExTEZKcFpnaWIrUFBXY0xlbGlLaitXTDJz?=
 =?utf-8?B?K1g3dmhxNHFKZitKK1pGNHRqQnYwcjdmT1BVZTFJcWJPbjk4Q3lxL2NwSVFR?=
 =?utf-8?B?L3B1c012dG9nSzFPUWgvSnF6VHRFci9WZDFvRHRLVjZ1YnpnSFc5K2wvVGlG?=
 =?utf-8?B?aDlzem1WYWRmY1dXWVdwQURPanlyY1RRQTBXV0NMRnhxL002dlJEYXZjRzdo?=
 =?utf-8?B?akZ4ckFCVnhOeExHZEpGTnIvMDVpMDA3S0FUN3N2ZWMxdHdEc2tGOVF3VmFF?=
 =?utf-8?B?Vys4T3JUK2RiWlhVT3ZhUGJ3cmxpMVZDMjV3ZU5xZGxwVmpkV0txNzhZRUpa?=
 =?utf-8?B?RkdiVllJcGJYdUJJejQ5QW1Fd2huKytjOXhKWi9OOFFYTmRKK1UrTVkrc0gz?=
 =?utf-8?B?MkN5bS9tcnQxbkZIK08xbHhNTkk5WlJNRy9FN3o4Ti9rRlNnRk1YSXdHcEJu?=
 =?utf-8?B?NHA4MXRmZjR1bnE2dFc4QkR6cWNqNldFb1loR244Zkl5dHpkbEZyOExlSjh1?=
 =?utf-8?B?OHA1NTRWbnYzNFhxTFNaeHljU2lMcDVMcFBldWFXblNyVTY5aDhyRHVjL0l6?=
 =?utf-8?B?a0R6MU4wbUJQNXhRMEloQ283N1VyRVdxa2hUMGprMm51SlFUcU9XMjlGMHBN?=
 =?utf-8?B?V1NNRnFNZkE5MkQ4N2hCekdGQXlKd0lOOXZTT0RjdFpYL0E4d0NrRUgrRDBn?=
 =?utf-8?B?UndJTnBldWRsZmZZdnZMbWhEaXVHc2sxT0VMUWVpSWhKWVdCemhjSWFnOUZ2?=
 =?utf-8?B?a010Y2d2SVFSSHc1TEpIQTZpZW5HMlV5Z3hrcWlxcnVFSERxVUwyYnQvK3pi?=
 =?utf-8?B?RmRrSnNBM0l3dytBdGwzRUVwZVY2c3VIQ1h5VkpVd0FwM3RZRkNpRUlBbmFq?=
 =?utf-8?B?QzNCZnU3VWg4U3ZFTEdlSXFKU0h4NS85UGdmWStiOGVqTnFTNVhrTk5vYk42?=
 =?utf-8?B?TTlveWdCcDBqMzRKTW15akJ4bVE2cTUyRndxa216dXIxbmIwNnV0dlJkbmV3?=
 =?utf-8?B?b0ZpY0dxVWk2bDMvUi9xM2diSDVFMHhtWWRoU2c4VUtqWU55cURhSmRYeWlv?=
 =?utf-8?B?NEpoSnVEQ1lSNG0vWGNGMkx0TUduaFpWbHNWcXVMVVF3SGpCR1B2VUpEZFhI?=
 =?utf-8?B?ZlFkdFdFN2tyYU9YZTJhKy8wbFgwWEYwUmgzRHlCZXd5ZDB0elZyTHpYMWYr?=
 =?utf-8?B?SlMvaU5CaUZWcTYvQmtHdGRVckFDa1RPYlNIemZUclo2M002NmhYOXMzQ2hy?=
 =?utf-8?B?WTNtZ0p4RkovNnBaVVNoYm5ycFZpbHpCY1Zuci94NS9YM2FKK1J2K3VrWHda?=
 =?utf-8?B?ek4xUzVVbGpGMGh5V3RWS1JMWmwxdEVLK1JCbDBzNjFFc1BnM2NOYzQ1MGV2?=
 =?utf-8?B?ZXB4S3B0cWltOVNxK3Ewdklkbjg0WEpSVm1UMHMzbzVwWGZKZzI0VUVMdnUx?=
 =?utf-8?B?NGgwVDdNNUdqcithU0lJTXc2Wmx3YXp1UDZKRVZkRUIrL3Vsam9uekpvOS9Z?=
 =?utf-8?B?VEEza1FGcGIvbnpLNm1qU1E2blZRWGhNeFdMR2tncUMwSE9QdkhHbzA3d3BS?=
 =?utf-8?B?REdldlBIbmJ0bEhZdXZERDYwVE9ielgyaGxPLzAvVDNnWmxtUGYzREtLTEp5?=
 =?utf-8?Q?wU9Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7393eea-2dd8-413d-84de-08dbb3953207
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 13:35:57.3394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KFoC3RT9hAYcIJaFX2RH4fBc9dJaqMrW4/xuMLVaJo1WLbr7QCejG294bTwKOsHay8bbrstJBJ2ZrhzNDRFgwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAyMyA2OjM5IFBNDQo+IA0KPiBPbiA5LzEyLzIwMjMg
Njo0MSBQTSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxs
aW5nc2hhbi56aHVAaW50ZWwuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTIs
IDIwMjMgNDowNSBQTSBJIG1lYW4sIHdoeSBkbyB5b3UgdGhpbmsgbXkNCj4gPj4gc2VyaWVzIGNh
biBub3Qgd29yayB3aXRoIFAyUA0KPiA+IEJlY2F1c2UgaXQgbWlzc2VzIHRoZSBpbnRlcm1lZGlh
dGUgbW9kZSBTVE9QIHRoYXQgd2UgaGF2ZSBpbiBzZXJpZXMgWzFdLg0KPiA+DQo+ID4gWzFdDQo+
ID4gaHR0cHM6Ly9saXN0cy5vYXNpcy1vcGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29tbWVudC8y
MDIzMDkvbXNnMDAwNzEuaA0KPiA+IHRtbA0KPiBBZ2Fpbiwgd2hlbiBTVVNQRU5EOg0KPiAxKSB0
aGUgZGV2aWNlIGZyZWV6ZXMsIG1lYW5zIHN0b3Agb3BlcmF0aW9uIGluIGJvdGggZGF0YS1wYXRo
IGFuZCBjb250cm9sLXBhdGgsDQo+IGV4Y2VwdCB0aGUgZGV2aWNlIHN0YXR1cw0KRXhhY3RseSwg
aW5jbHVkaW5nIHRoZSBSRVNFVF9WUSBjb21tYW5kIGFsc28gY2Fubm90IGJlIHNlcnZlZCBiZWNh
dXNlIGRldmljZSBpcyBmcm96ZW4uDQoNCj4gMikgYSBuZXcgZmVhdHVyZSBiaXQgd2lsbCBiZSBp
bnRyb2R1Y2VkIGluIFYyLCB0byBhbGxvdyBSRVNFVF9WUSBhZnRlciBTVVNQRU5EDQpSRVNFVF9W
USBhZnRlciBzdXNwZW5kIGlzIHNpbXBseSB3cm9uZy4gQmVjYXVzZSBkZXZpY2UgaXMgYWxyZWFk
eSBzdXNwZW5kZWQgdG8gbm90IHJlc3BvbmQgdG8gc29tZSAgZXh0cmEgUkVTRVRfVlEgY29tbWFu
ZC4NCg0KPiAzKSBpZiB0aGVyZSBpcyBhIGRldmljZSBkb2luZyBQMlAgYWdhaW5zdCB0aGUgZGV2
aWNlLg0KPiBUaGV5IHNob3VsZCBiZSBwYXNzLXRocm91Z2gtZWQgdG8gdGhlIHNhbWUgZ3Vlc3Qg
YW5kIHNob3VsZCBiZSBzdXNwZW5kZWQgYXMNCj4gd2VsbCBmb3IgTE0sIG9yIGl0IGlzIGEgc2Vj
dXJpdHkgcHJvYmxlbS4NClRoZXJlIGlzIG5vIHNlY3VyaXR5IHByb2JsZW0uIE11bHRpcGxlIHBh
c3N0aHJvdWdoIGRldmljZXMgYW5kIFAyUCBpcyBhbHJlYWR5IHRoZXJlIGluIFBDSSB1c2luZyBB
Q1MgZm9yIHByb2JhYmx5IGEgZGVjYWRlIG5vdy4NCg0K

