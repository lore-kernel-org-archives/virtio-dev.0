Return-Path: <virtio-dev-return-12792-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBF0C7EE2D
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 17:28:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 24B2CF9371
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 17:28:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 078FE9864CD
	for <virtio-dev@archiver.kernel.org>; Tue, 23 May 2023 17:28:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EDEB1986387; Tue, 23 May 2023 17:28:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D920D9863BA;
	Tue, 23 May 2023 17:28:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D71xsfp7ceA73ptvpUiJPxaFZTHIq5IUC6tXIZCV8ZX4ZsVT3/zWMDBRyiQXKH23B5/WUAa/jZ/rfcbl1vGwbjp6l4gYT0N1ZpN9XLHuKJAWSyzxeqegMVLCOXty1fSAFMBqc2Q5mwn6aeZu5SKt8YRPOSg/MNK30FWqiBS/ediYr7/oSQ79xM/5VbnAlbCsWdIXnjhH4P+mgi3h12fzezOhLpGZIPuh7ehRhpZL+XlMvwfHQZstB7pgnvcyXOYlQi8oK6g5YO1vugaq1IqZmsIL+sfpszQAWAmIeNN0ENPUbZRMAYPJmcH/419WyS9Jpbthj4WAX/F6kz7BGUh+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QH3bkFJk2NliHbvp8GwDAol5P5wq4PD+bAMAahbbqvw=;
 b=diTUZP0iI+wA3L2nCFifbKJc+3iXeyMOYjkD+nexneDi/zY0HduWWsimaH7Pl3fKtMqXehz7E2pt0COyBZL5rdlDZudi+mpaU56zwdv1ZyT4ZhlHMHeTke91eDGlZbGX7olff60Cgev3kngGnyrBTXATXuLLNHKl/rPYfb/m8gDVyquTjC8BMpIvGZjBTGxwL5ZS/uuK1o1PXKGGZNQmXtzPT97kYsWbF2KPKr9aiboi+BWdIrZeR5HPdaFvGBtt8JXCDBSSi896AoxlB69rQmxm4z1IjUyzPSEGjd8JHB7a19hZQfYwXdhi0FmSVw6wW1m1JEdZvJSvomoQBOjKYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index: AQHZf637tzEcVLD5bUyVf2EjaUYU3K9ngyUAgAC0dtA=
Date: Tue, 23 May 2023 17:28:29 +0000
Message-ID:
 <PH0PR12MB548106A6E54ACBE8BA4E269EDC409@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <20230523022226-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230523022226-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6017:EE_
x-ms-office365-filtering-correlation-id: 8a0f6d95-9934-4ae9-33a3-08db5bb32025
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hylG5EtlG4YZPlHLh1oftdEngBa6y4YIjrujFqy1sKWBauB7b+PQnPq5IESa79xypNw2TsQouFDdk1PYDjjmTpAUuGvVg9Qwzeoogrs6IO3G8hvYKJn3QCF7d9ivnyeQaRa+nhtWF8RaQ8I7xIPKz2MkqgRTmADQbrmB3MY+oWRpTk4CNoT2X06ULaaC+zaVNf+zKxrCJzfYJ3avS99pNe2RWL+2C3tXeeiwAXOcKiK0wLQ/wbNtHyhemd4cXLFGSVgB3xdoxD4qZnTsZzCbuMV2M2Y4/SfDKmKNkvB2Q7RsP3RUuTDRHn8NPKijMiTt4Tc08PaI1D61WwuYy5oImNFnyOXxIvB9NLFsIMgTnUJmRCDhugZNBJNfIFn6W109RRmbGGqJuF0yOLV5jdgHT6qTEfJqBrNunEMMO+RHOZWQeAouJJQqs019F2W4uCzy15tt+YCCiBEPqvz2hnp6gSB5Mnu7/ecQHdhF/QhVKviPRJIAtuC6X+ds8OgEV18gbVPbTCo24xL6HE8tjxdlEhY7FGfs9LcTJz/67loqpubXYUo6jNFxw0FaNNWQTgzwg1lc1/9cxlgaaDwJ3WfwmR4SLZNwiJDvT9Pd6h4aT90NEIVuAEFvO56cFdfLu4dP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(8676002)(8936002)(5660300002)(52536014)(33656002)(4744005)(2906002)(83380400001)(186003)(122000001)(38070700005)(38100700002)(86362001)(107886003)(55016003)(26005)(9686003)(6506007)(6916009)(4326008)(316002)(66946007)(76116006)(66556008)(71200400001)(64756008)(54906003)(66446008)(66476007)(478600001)(7696005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UEtWVFVvTHJuVmpaaWFLRHFRdVNWSXNvbThGb29IWFNYaW5pbjc0SkdpU0Jp?=
 =?utf-8?B?dkt3K1NtOVJJZmRla1NtVDMxQTdtRHEwaUJ4RDhxMnN1MVcyVVkzWm50czBK?=
 =?utf-8?B?RllSWGJPN292dWY2Z2VOR3hQbGJ5a3p2ejBFY3J3QWhpcUxYZzhvNG9Xbmxl?=
 =?utf-8?B?OEtTaW1sMTNNSCs0Vk0zRUlGWXl5SHN4SElKMU1KNGVsQ2doTlkzYXl1S3N3?=
 =?utf-8?B?MVBaTzArdm9hVWljMkhPK3krN3I3bDRMc1ZYdnFKMlFySlNEbndwT2ljT1VS?=
 =?utf-8?B?QndZeTNhL2IyckVRLzB4N3p1eHdVdzNETzVVY0NYWU43MkFPRkZzbVZ1OFpy?=
 =?utf-8?B?ajN3ZzNCMXJmVXB4OVN5RFArbzhoU3B3Vitab1lrMUV6RmtqRyt4aU1iV0FD?=
 =?utf-8?B?SlVyWXlubklmZlpDdE4rNkx0VDNWS1JYcU5Ga3VGblFrM0VoZjZrdkJ0NnpL?=
 =?utf-8?B?eFpyUlhmU0pLYlFBLzV2Z013YWIrUlg2Y3duSjZIa1d5KytuSkovMjJRM3RE?=
 =?utf-8?B?VzBsRU9LcWhEdzZnWWNhNzJoOFUxU21TaThVMGJISEdtMHNqL1JEclViSkdT?=
 =?utf-8?B?Z244WkxYRmxtelh4V0tpWDhJR1pDRlN4UzE4ekNNVXpBWXd3VFVxQnltdFBB?=
 =?utf-8?B?MkxaMGoyendaQjdnQmEvUkR1V1VuMTJMUlZmZkRZUmxZOWRHM0NaMi9oNFEw?=
 =?utf-8?B?c0J4R2ZQVk42UXJMdEtjWWg5Mmc0RDRZRlloRW5HYUJCNk5kU0ViSEpIZWxT?=
 =?utf-8?B?TmNzdEZCQXh2bWNDMERkeUo0TGRUajlpdUdVZlhzUlc1T2piQTJ3RE9DUkcw?=
 =?utf-8?B?cWFTNmpzZEd0WFc1cFoxdWEvLythKy9hNHVrUEZicHF1RWpGclBXOEp5TGZH?=
 =?utf-8?B?eURqS3ZtaEVtK2NKZklFMmdlY28xbnk2WE9pZEdMcFBub2dBR21lNlZJbVRT?=
 =?utf-8?B?dDVIcGNCRkdqUDlKQ1FMYjdnVFgxZ1NqdXZQZjB6d2dybFNvZ2IwRjN1bGc0?=
 =?utf-8?B?SWU5cklGQ1MrdFhDY3ZRQ2tMakt0d2ZGclM2Mk1aRGM5UEgzbTQ3VWJNbGFY?=
 =?utf-8?B?QzF3Q2ZLck9PNjlXRHhjdFZRd1NHalZ2dkhGQVg1QXhrSWdkQWZJTWxzdi9B?=
 =?utf-8?B?N2wyWjlGR1ZEYlBuanpFYzBYNnpDczhuMExTb25DZEJjUk5QM0tIMTRCMFZx?=
 =?utf-8?B?Z3dQTW5NS0JPb1NaNk1KNDREWEN3bWhoRXJnblNUZzQ2Rlp2MkVaUW82a1Ro?=
 =?utf-8?B?OCs3WDNsN2FMNzk1LzFlZmNaanlQZWRXbVBYdS91OHV5VUdsZUYyM2t6M2N2?=
 =?utf-8?B?ZTE4Q1JLV3NYVk1LSGJrMTNpVnc1MGJtOTFjM1l5YTBKTVNodXNOa1ZjRXhv?=
 =?utf-8?B?SmhnRVFMcFhmTUcydHhnSDFrQ0x2UXFvdVcvRTR5czFoOWFIOHMzeHMwdnhE?=
 =?utf-8?B?NVhoSkJJMlpDbVFKWnhmOC93MWFhVi8zTmpPS0tlRUk0Wm5vWDNYc2dZclN1?=
 =?utf-8?B?a2ZHcTBnRHVHS1ZyZDNHNjBzTFBVeXA1SjhHZkZ4em92RGtpSS85R1laMkxW?=
 =?utf-8?B?TFFEWTdKekR0dVdVekZKZzBkR0lla1NqeVh0QUs4WnRiN0NjNmJTRVduVm0y?=
 =?utf-8?B?bWo1Tk0xY3ZzY0trajZEbUZrQzFkZlh6M0RqS3lvVDU1bWRzMmYxakVkSFNn?=
 =?utf-8?B?K1BkSUpoMnhYSGU3SVROd3VhR0xQS3E5WUwrYkNVR0JPUXdMb21GSW93YlJ4?=
 =?utf-8?B?bjJMRUUzSHptanRtVHVoRkxaUkpLYVhDMW40UUZrZlZJTllQdzdYRURjMmNs?=
 =?utf-8?B?aEZESTExcTFNU0tTR2hsa0VDMnNhTUVyQU1xK3FOdm14akgzVE0xM3p3aEN0?=
 =?utf-8?B?UFpkUkZXT0dNN0srWDNSaFBxY2pNVWdpeS9FakJpMXB6QmVIa0k4MGJOY2ZD?=
 =?utf-8?B?WEYyRHprNWdRT2lmMnVIQSszU0FsUUZDYVdUeXF2Vm5yVEt2bDZ0WmVmalNk?=
 =?utf-8?B?SG1URld0QVA4N1B4K3BIdk1DRFFGV0ZXVU4vWHpWUkpPN0txZmViTkdOcjNo?=
 =?utf-8?B?c2tRL00rSVpZZTE1MW9acXZmZUl6Rzg2eW5JekQ4d0tPcHIwZ0xVWThGRTNS?=
 =?utf-8?Q?DFfM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0f6d95-9934-4ae9-33a3-08db5bb32025
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 17:28:29.9034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 746iTnk4vlcynX3e05u1O+QjlPwULrDX+HFFFOEjjNGb4NU28MmJvJEdIA7O/roApSJV7Nf2cFus3XoUJjqbrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

DQo+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1
ZXNkYXksIE1heSAyMywgMjAyMyAyOjM5IEFNDQoNCj4gYnV0IEkgd291bGQgbGlrZSB1cyB0byBi
ZXR0ZXINCj4gZG9jdW1lbnQgaG93IGFuZCB3aGVuIGRvZXMgZGV2aWNlIHN3aXRjaCB0byBhbmQg
ZnJvbSBsZWdhY3kgbW9kZSwgYW5kIGZvcg0KPiB0aGUgc3dpdGNoIHRvIGJlIHNvbWVob3cgcmV1
c2FibGUgZm9yIHNvbHV0aW9ucyB0aGF0IGFyZSBjbG9zZXIgdG8gdmRwYS4NCj4gDQpUbyBteSBr
bm93bGVkZ2UgdmRwYSBkbyBub3QgaGF2ZSBzdWNoIHN3aXRjaCwgbm9yIHN1Y2ggc3dpdGNoIGlu
IHRoZSBzcGVjLCBub3IgaW4gdGhlIHZkcGEgb3IgUENJIGRldmljZS4NCg0KPiBEb2VzIGVuYWJs
aW5nIGxlZ2FjeSBjb21tYW5kcyBjYXVzZSB0aGUgc3dpdGNoPyAgT3Igc2hvdWxkIHdlIGFkZCBh
DQo+IExFR0FDWV9QQ0kgY29tbWFuZCB0byBlbmFibGUvZGlzYWJsZT8gSSBraW5kIG9mIGxpa2Ug
dGhlIHNlY29uZCBvcHRpb24gLi4uDQoNClNvbWUgZGV2aWNlcyBtYXkgZmluZCBpdCBoZWxwZnVs
IHRvIGlzc3VlIHRoaXMgY29tbWFuZCBvbiB0aGUgQVEsIHRvIHNheSBlbmFibGUgeW91ciBsZWdh
Y3kgZW11bGF0aW9uIGFuZCBhbGxvY2F0ZSBuZWVkZWQgcmVzb3VyY2VzLg0KSSBndWVzcyBiZWZv
cmUgZ2V0dGluZyBkaXN0cmFjdGVkIG9uIHRoaXMgc2lkZSB0b3BpYywgbGV0cyBjbG9zZSBvbiB0
aGUgQVEgb3IgdHdvIHJlZ2lzdGVyIE1NSU8gYXBwcm9hY2ggaW4gb3RoZXIgZW1haWwgdGhyZWFk
Lg0K

