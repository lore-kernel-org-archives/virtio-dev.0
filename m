Return-Path: <virtio-dev-return-13739-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2D4EEB58F
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:37:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C48D845B37
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:37:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C0AF2986641
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:37:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B389298612D; Wed, 13 Sep 2023 04:37:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A3502986630;
	Wed, 13 Sep 2023 04:37:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d24qK+NSKSuLU8Gi5/bVM7Q2CoeUnWpIXNedcrsxY0rYbPNNn22Wr5Bw9so1jpjXwqPJIYrpkjd8bTGjB0fyUDmOu+cqq+gespqOI7RKYX+h6CYz9TF1E8hc5t8015rI3XPjwGrKGFbt3HzqlR0hY00v/+/mZqZ22xYBvu78Gq6fsOdEkUFZNYGOAQtjIIlrQi+jHZOD2BnX1/sRTSwW5EvS2FMyAWi0Hq6DIvODn6J5KT46ve3UY+8MNxoV7kZonpiOsiQm2p/iY07kUTxa9o8j0G7t82CBeEsAOXA74UXSJWaKr8wO4K7L4huf1svI4bEP9hUfI7UtNeqZwgzUrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJ0LAg7yLAjAVylsz4Alr/znIoygfe71DjTxrOxyOeQ=;
 b=njljXYPl1hUPBNW7ZAHZExvsCNpQ/qLFGd6YrFbV7R48kn+TmjVb+R3QmNDnVeZp/LlZ28IhdmZaXxzM3SVjOBzfVl16jx9xR5MfXSfOB+hoLA7EAlMgesB9R8Ak6cab6X2TXXYZhLZKupVZYsCBED+q/47a+jIb14mRqTYvFhUXw5z+oSXBnp+Rm3SjoLdO09BZ0pZQDxjYbrreRzGyqTTsPtmqAELSmBwg4EOimror+CI1R6ONQOonTTsMok1EvcglTUugZA5F7Gn8stzWV9GgJ36UAhwn7I/CM5RbyWM6aPx3gpEmzjACVBDgqxTB1d0TV76yRwnME/stZsonww==
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
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAlTICAAQzqAIAAIezQgAANVgCAAALLcIAAC5qAgAAEIzCAABbWAIAAAKAAgAAF4bCAAAyxAIABDe5ggAAckgCAAAKaYIAAAoSAgAAEYtA=
Date: Wed, 13 Sep 2023 04:37:51 +0000
Message-ID:
 <PH0PR12MB54814FAE1D790492C8D660E9DCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <17514b93-2da4-42b3-a5bf-b96358a7a875@intel.com>
 <PH0PR12MB5481F236858D5CD97EF55732DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9fabd346-9b6f-a727-3de8-813ec3570772@intel.com>
 <PH0PR12MB5481468378DC1E5491A5427CDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2baee870-bf38-5d83-0543-1d0a68f8e651@intel.com>
 <PH0PR12MB5481A26B62962979C19280D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8bd1c228-856a-9454-752d-750997c4f4db@intel.com>
 <4c195683-0eb8-5e92-d97a-217cfa8af760@intel.com>
 <PH0PR12MB5481860AEAD92C74A5BC19F6DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f132cd22-e2e1-971a-894a-d62aa7ca6334@intel.com>
 <PH0PR12MB5481EF64F3BA3D13C34D016EDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2f34daa5-3db3-fd64-550d-86678acbfef4@intel.com>
 <PH0PR12MB5481BB050713B687EDD07FB2DCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9d9ac82e-8eb9-558e-916a-c327e3c3a996@intel.com>
In-Reply-To: <9d9ac82e-8eb9-558e-916a-c327e3c3a996@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7105:EE_
x-ms-office365-filtering-correlation-id: 7547ba37-53f4-4322-fefc-08dbb4133061
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cuk8OU7fosrnGNAzlRAwEARJM1kcYRGnvQjbqxazR5Bey0I2HByXV/DynVJGc8x42DZDlgmXH48+C1WQilhz6pQiK5Ao5yiTyGaMBl1PPBot8aXfnJYpWHdEZcwsDxTdH3qq8dDTGqykv/zX+f/7nyC6lZhYvKxHRTBwUk1ASJSBxbow5MEapWM19+VB/ov1NZNtGzbhHhL3o1N2P63XjhJLlbmlLRDKuJXNLpYFDBC7i5UdaGaoUzq3CuHy6wHPbSr6QgiE00F9os7BcW/AszEI6XTMjAgQIwcOn0n5jx04EYjGWL3EWNGPCATnqc/1VhEyZnmOZu8jXLOvbiK5SC7kv2RPBbhBF5g0r3Jk5v9zQeycnnve3xSgcZ0lzNJvpmlXBeS6SJ+/NjDbxxltIgKBbujyc8L0+Xkvj+4LbLNy0j9fyLrSJN85uEzkL+qH8yPjO3t/p503ERwVjWOt+SPWHTKbn8yHSJwOch2lRxmOVcZ9TJB6+KI4SBBsBk9PIE5emKRtAxVZIFTcfkcvi9gjFFQ7RHOG0Mr9q1Heg3zgdhdbUfXDdRHWmrpSsHECOWlOnUulDfIkm2S2R2EW80c5Q6ZYAlB/nXSqTZNf3lYIZA3FY5u+PnnrS6uGrFkk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199024)(186009)(1800799009)(122000001)(71200400001)(478600001)(86362001)(6506007)(64756008)(7696005)(26005)(33656002)(9686003)(110136005)(55016003)(8676002)(76116006)(54906003)(4326008)(8936002)(66476007)(316002)(52536014)(66556008)(66946007)(5660300002)(38070700005)(2906002)(558084003)(66446008)(38100700002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTZWOTVJZkJhQzFQY1B4Z3loUHROc21tdzA0Y2orMm14eEgrVUdTZGVQUVQx?=
 =?utf-8?B?QVJOalJZVFAxUFBKQ3VDeWs1YU9nS1BjRkNTV3BHQkNOSWI3M21RZUN5M2FW?=
 =?utf-8?B?MDdxVWo4d25FSXM4dzgvSDRVTCtheU1KQkI4eWliL2JBY1Jna2hCOWltMEdy?=
 =?utf-8?B?VExVZTIwditJemFoWlZLT3BzbjFZZ0pGdUkyWTdzN1ljbUU5d1RWRUk3NWI2?=
 =?utf-8?B?QUpqWC9FY2N4c3VlOFVWR3JWQmdMYjN3NFJ2dVFLcE9NMjg3TkZzaThiWCty?=
 =?utf-8?B?UUxMMTlCZFc0R1VtbVY0cHhKMit4dzRkVVRVcHBvaUM2MFhUd3FWZ1IzVFpp?=
 =?utf-8?B?VFdwNWpwaGpRRGVocGZhQUFBMlIzWDFpRXRCdGtYT29nK1FEVzV5UW9pTG5U?=
 =?utf-8?B?YzhOUlhnVUhlTkJvNitsVjJWYjhzaGI1MGs1OWt1blZiWFpIS3gvKysyZHBl?=
 =?utf-8?B?WkdIUXVqbzBweGR4b25IZEV6azR5WU5INEZsVGxucXZFOVBJY04wV2FSVk90?=
 =?utf-8?B?MzJYdFRVM1Z5SXIyeFVkaFN4V054TGFyMGcwb3g0YjY0WTBuQjIxc3NYTmRo?=
 =?utf-8?B?KzBQN05VekdITUl4UGc1ZURacnNLY0xZNDlkbXFaSzZEdklBREtBaC9lcmZt?=
 =?utf-8?B?V3BCbmljS1diTVNmeWZVbmlYSmpJYkllTDE0Z2xCYzFiTGE2a3VpZ1g3b282?=
 =?utf-8?B?YzdLdFExRVI3eVFNVVpoWkVCeWh5c2p1OFF5YlZRT2ZUNVdLaUhVLzBONlls?=
 =?utf-8?B?V3RyUEJCZkMzTmRHOGo4K0VsRDBlQ1pLL1ZsNzV1Q1MzSDg5TnJFb3pWN1NI?=
 =?utf-8?B?SUtVQ052VzBOdFhlVVNOb084NWtUcTE4TndYUnBqUi9SWHVXci82YURjQ1BC?=
 =?utf-8?B?L0pLaUR4UkZMaTV3ckpuWmx6aWQ3bVlXUFNwOUptakJPWG5iZXVVL1RaUG9l?=
 =?utf-8?B?QzZuZG5sN3FBLzB0U2k4QnFndEhrTmR0MmxHSm1wZXJtUkpYbTg2ZDNpZ1NF?=
 =?utf-8?B?RkltUXZFMUhVTzdUbzhyTHpJK0UrdWpoTG1rU242dVVoL0szcVZoa0REVWVX?=
 =?utf-8?B?MHNvMWtwa3ZWWHEzMUNUOXlwa2tkQ2NySnAzY0ZhcFRRelorR3crbjZrclVj?=
 =?utf-8?B?eWN6Rjh6a3o3aTQxeEVvTGhJODNrbE51K0FTM3Vqb2hZRy94Wm5nckFJU3RD?=
 =?utf-8?B?U2tuNVRxT2Rvdm5IcTZrOWltTjFLZ0w4RG9aSGpEaVhFNDR6S1ZrOWhRcE1r?=
 =?utf-8?B?TCtQcjlKYXVGMTlqL2hYcVdldjlYc2dDVzlLUEMxMFB6dkJNNUVUejl3QjNv?=
 =?utf-8?B?YWJmZXZObnltUUVMM2RQNFprSm1TSzcyZnRRZ0EyVktIV0EwVnU4WUNndkhO?=
 =?utf-8?B?OU1TSXMyQjVnRkdXZFRMZGRNT1M4Z1RZNXR6L1NxZ2pZSjdKdTRSMkdTeU1a?=
 =?utf-8?B?WFFvd05GbWZFLzZJSjFROTVkOGtWMmYxQ1R4WkRkSUVnUVlmYWpaUFJCcitD?=
 =?utf-8?B?S01HWTI1S1pndEpCRmdjNjdWQklJUmhUMFdGZDJkOUFzTkNjRG9lbFh0MEtE?=
 =?utf-8?B?SlpiTTlhWWFoeUxRRHdvSHFxMGVCUjhJYlRabktSemRnMnZ0SUt1ZDJkb3NL?=
 =?utf-8?B?KzNSWGk1Ri82c3hSUDV3QlZab2k1SjU3Smxqc1I4d05SM2F6dzJYckRmWE91?=
 =?utf-8?B?S1BDaWdzWDZwNUVTNmltQjJOOUY2U0pUZ3k4YnEwWlFPc0tRT1dvT1dkc0ls?=
 =?utf-8?B?QkpScHJobGxKWXYzZU9BY2dSczRhNnZYRnBPcFpNM0pkUWxaMG03SEFSV1li?=
 =?utf-8?B?Uk8wTitibDBoYWpqZmZSeFN6RE4veTVMbWlNa2lrYm93Wmp4Yk1mb2lTK3R0?=
 =?utf-8?B?MUF4aXBTVWRQYTB6VkNQSXlCZ3lWS29PMngrd0J2bnBjQlBQZ3VtWWZwTUhj?=
 =?utf-8?B?RUFITUY5UW01UStOcWVRa2xYZEVBRWRiTEJaWWY3UVFoYVFqVUpCS0pGUzFp?=
 =?utf-8?B?Q2JoRlNDQm8xUzVGTVQrMlR5RzBtNUxCU0puOHcrU0Jkb3RuOHZYOUgrZ2xO?=
 =?utf-8?B?bExhVGpvUUhtdmtwbHpKTjlsa0I0MzRhQjBPQnYxRnlvc0lEeHd0V1hheTBx?=
 =?utf-8?Q?AnLY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7547ba37-53f4-4322-fefc-08dbb4133061
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 04:37:51.1963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7IEtFJDpoJ5kYh59lbZviR6iQ6dj0BGU5o5iS/pI30QYJollIhUaY3lJE7eWMOvTO6081ERcNufGlH7ZiNT/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQoNCj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTMsIDIwMjMgOTo1MSBBTQ0KDQo+IHdlIHBsYW4gdG8g
aW1wbGVtZW50IGEgc2VsZi1jb250YWluIHNvbHV0aW9uDQpNYWtlIHN1cmUgdGhhdCB3b3JrcyB3
aXRoIGRldmljZSByZXNldCBhbmQgRkxSLg0KQW5kIGlmIG5vdCwgZXhwbGFpbiB0aGF0IGl0IGlz
IGZvciBtZWRpYXRpb24gbW9kZSByZWxhdGVkIHRyaWNrcy4NCg==

