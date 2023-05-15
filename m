Return-Path: <virtio-dev-return-12683-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77156C7EE26
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 14:31:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DEE9329FD4
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 14:31:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9A2F9866F4
	for <virtio-dev@archiver.kernel.org>; Mon, 15 May 2023 14:31:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BD72098651C; Mon, 15 May 2023 14:31:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A9837986509;
	Mon, 15 May 2023 14:30:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEAiP3g/zpe5IqvAG2QWtEBLJ0evRtJtZW0vumnabMQAlpaWlkfuDGxmsIYxDNGkx7FCZnB/0mHCsC+BlsVRCPCV6ZF9bPZfE2smwDqavl9juSW4PjzyCfmG+uWI9l3PWB1ALHV3cSDeUMLEWgEymY7Ef41RCjYMqAWV3UVHFzqz7GO18H47hLqwxfVrkNOwqKIKOMNNZ+ZqoYfjdli3QWXdJzrmusV0hZCqiNEikigdbVPVzJkddRYapSAXew8TMwyfdSrr/PGBxclQg7SrTtP0yyiEX8njW8WBuWXNkSTN+mzAV9x2+enCca0pkS8H48pnK5PWcuDikUqRe+2vHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yO3/EsWaMKmIkJme6+Bt8r/yZVbsakVspnmv8CcVyKA=;
 b=GLOLqbOX4+3zjpEU/iz35cykINYLJLGeEtCGcP+JtAy6U9drFOtYc1V3tfAWgIGWXZO7cA3t7X5sYUWYyEo5qEqdYUKVJLdNP0Q14qq3YZA+VCz/PIiVq8EAF9y3PVhPa93P4fu/tw8jsFIyvc++SJNTZmAxe/ukhe5MSSnlR7406tD9V2sDBjQlK3KhPbInTlCZxPcpmJhle3sfwaIgpX2bTQ/jo5BpazlLuWmM9eLWNgd1Otmoj2pjND+etctU8Q9lL0QYvpz6gtpm6/L4plRo9YkYqNDNCA67Z20+NtvsyPMtymTlfo9mAyA+Qp8bZ37HTpbR6zbYZGVY9JhLWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgAAP1ICAAAu1gIABh4gAgABhyYCAAABooIAF7m6AgAAsIgCAAEhEoA==
Date: Mon, 15 May 2023 14:30:55 +0000
Message-ID:
 <PH0PR12MB54817BC2F2FBFE3609AFA23CDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
 <20230510033812-mutt-send-email-mst@kernel.org>
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
 <20230511085205-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812F2EFEC7B6A235953A82DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0f75a142-71e9-676a-11ae-a54e6dbb472d@redhat.com>
 <20230515060641-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230515060641-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB6136:EE_
x-ms-office365-filtering-correlation-id: 087c70dd-4d9a-4edf-a84b-08db5550fe37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 63/Z/k4wNmFb7RYTBxaHgctBw61EvIMhZnyQCERpq8mu1thcIzorC6P/mSIbABQQtSfcIFpaUEM9vSaN7e7Emq4izZUpBhJu0WGJZoDLX3BeUPHiqUOcuO8N/jUnmlNNZyRoWCHVr/6UwVgBlm3ERwiI0JwN1eQ7B6B5EGSHEtCBLYNQJtThqS822gkIreVDTrkUeH+SvYnLkPPhe5TQXWquNAqwe+vyvvZs3287CCGclC26zOz2FD/rtJTMpI+rcB9OIloCJnJyQZ57QkMZ1N2PNOxjgVlcqRQ0UepjUyO9QLMhcfVYD6J8yGjQNxgwpKdufEeWSNXgvUMzs2vu5OE8SZGnfpghen+5LJeMSgqA2y++HAXD2EDGpsjLn5GjXZsXvOJBVLC15pbDfZxjqPutgURJwmrqTkzdgBy+fvbcPAUTrYAUb0yfpUgABUU5cFflhc15bptHwcTdJ01PlrAbSpnO7g7RHtbrFDvUgY/CLEvAHIwA2piJA/8XBPckque1ufBRiteARXUk5gSGx91XGO6iRGFXIPEaWw/w0hZSH1+qY0y/B1Hc6L7BXrowxKpJjS1vE5XBg28H2ZXimpSc5JpN+IH+yNLvbfWHnSpVarZeSUlSjrOlPqnKelpe
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(33656002)(86362001)(54906003)(110136005)(316002)(64756008)(66946007)(66476007)(4326008)(66446008)(66556008)(478600001)(76116006)(7696005)(4744005)(55016003)(5660300002)(52536014)(8676002)(8936002)(2906002)(38070700005)(38100700002)(122000001)(41300700001)(186003)(107886003)(6506007)(9686003)(83380400001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWZqSHIzTE1QWnFxYTFPQXRmdkx5ZkxkK1BPbmRlQWlkTTVHUitoZTBReVE0?=
 =?utf-8?B?Z3hPTzg1dW9zeHBzdlptQ1kxVWNPaGVLRHV0TEpvYStKcXFJb3VsWEVYS3JO?=
 =?utf-8?B?VW5abzE2OUJRLzRrNHVtYWVJdXJ3ZFBEWExHLzc1YVowNXBWV1d5UnlqWUJn?=
 =?utf-8?B?enpBa1JQK0Z5RVd4eEovRytVdkE4dE1zc0hvL0E5S1ZaYVhFcmZnQ2FPbGR0?=
 =?utf-8?B?dTl6YU1yTEg5OVZUaitXcEMwN0tIRFpsR1RDd05TS2ZHS01USnExSTF6ajZ6?=
 =?utf-8?B?MXpQRDZaVkxaekxHRlFidko1ZUJNb2Q1b1kvakZMSjA5dUZtcTdMWkNTMW5J?=
 =?utf-8?B?VTRQRzMvM0ViK1poZUdiR2c1SUNvV2hxd2QwU1hrc3F0S3hQNGQ0MTJMVnE5?=
 =?utf-8?B?cDR5VEtLZzM4ZXZsM2VKTXF0bXdSd3YxdnJ2UHEzQXRPaE1YV3k5aW92S2RT?=
 =?utf-8?B?Q2E5MHpnL0J6WVcrUHg0aW5jOTBwUlNUK09MSG9KcnBsNEk4SmZOa0RSZUFX?=
 =?utf-8?B?MGw3M01uU29CUTMwc1ViaXdSa3RNTEVxMmRCcnBQWk8wMlpITm05YndXaFBK?=
 =?utf-8?B?RXcwVFpjNUcxT0Q4bEhNUXUvNE8zcDRzbWVwTDdtdnBzOUo2dlFTYlZ3eFZa?=
 =?utf-8?B?MFppRTNVNEhMYStKa3VONzBzS2dQSGhNRndSVGJmUHUwYTIyMjBUQnpqelFQ?=
 =?utf-8?B?WitFQ2w5bFNOUGJ2K2JnSFV0UUo4clZKeWZTaGY2OHM4em5mV280bktFelFy?=
 =?utf-8?B?K0J6Tlg2RUtwZXF0ZS92cXM4OWRlTXd5dnhvbCtqUSsxYVVteGNwOGxBRzY4?=
 =?utf-8?B?MlphK1NOK05pNHpPaGVTcStUSTZMMTdPbnFNT3pKWkpmQ3JDV2l2OG9xL1ZG?=
 =?utf-8?B?UHpCdTFlL29DY1JrRnhJVk9HVFJTWkZQMVJiWDJuQnB4SzAxalczUHB3Umoy?=
 =?utf-8?B?NzI5L1pmZFBRb0REbGVCWm56S3pjNUxoQmVUdVpMN3U4ZWNQcTZWSCtEcTlu?=
 =?utf-8?B?Qnp1VnJsWThGZndTRWx5U2RqajkwR0hrWWNkZzRRSkZtaU5ZVXA0RGRicHgv?=
 =?utf-8?B?MXFxZTJRWXJieDk5UkhiZ1JLNFU5L0hUZ3RBa29vayt4U2ZGZG9GZ0F3TkJZ?=
 =?utf-8?B?VHJQTkpZMUVNTXlqWHJtY3d4V3VKNFlOclNGVmZnR0NNcjE0bW05aHlVMmNV?=
 =?utf-8?B?ZmVPbkY1U05RZnJ3TmZNUDZDbkJYdFVJQWFMQmxoYVVBL1JleVR0OXM2UEtk?=
 =?utf-8?B?bVhIOHprQTluZUppT2R6VkNHR1U5NGdVUjVGNkQ3ZlhxSU5LY292UE5CTXlp?=
 =?utf-8?B?QWhEbllid1FKcE9XUlVlcDBVR1lvV2o2ek13ay9pbWphMG80cUVzaU94RmJL?=
 =?utf-8?B?TFh6NnUyWGhCUUFKL1Jnd3VJaEo3NjJWNXZOb3d5R0p6K05hTEE3Wm9lWXJM?=
 =?utf-8?B?YzNBMDdDL3REYW1iZElOQUIzNGxrZDJ1emd5Zk84U1I5L3BrK1F2VWE3azdy?=
 =?utf-8?B?VHZ0SkcxcWpDSVpXSzY4ZzRVU2F0MTBPbjZkbll0NXFGVitoNmx3L2RMSmhs?=
 =?utf-8?B?OW9COTBvK3RtdVlHdW9wL0xFNGhZeFBoTkRlajh1OW16RlhPMXRTVlU1R1RP?=
 =?utf-8?B?QWYyMnFjVS9VSlpvWHZETFp3aW5UemVqcmNWUEx4WE02V3FKQWZhbUlSbXJG?=
 =?utf-8?B?QWhNK3dFL2RXbWV2SW0vcVh4bkgrU2tXR2sxa2FlcEtRbkJ4U1NCd1VMUDhm?=
 =?utf-8?B?Sk5Vd1NZTk41M2ZTMmc4Z3pFMjZFNFdWU0JVWlhMdTloU3Q5ZThicVkrTFdC?=
 =?utf-8?B?eFFJamo0R0NWRmdBbzZ1Z0tPNDY0YVBhaTdhVk4yYnpmeVo2RlNKOHdxTXpY?=
 =?utf-8?B?VzBERXZQckhMczA1NVVBT1RqeStnRExiNjF3UmYxNmhBNlhtajk4Z2pVcWhz?=
 =?utf-8?B?YjRoMzVpVXk2SDhVdWpGRlJUZlptS2E2WVFrazVoVE1mMzFoQnEzUEMwYmpo?=
 =?utf-8?B?Ull2dmw0UjM0a3psclk0QlEzdyt1cDJidWtGdTlzUExiZ2o3bDFQOVBwMFdI?=
 =?utf-8?B?dW1hdC9MdjBvWjIrYVp2R3R4YklWYjF0SXRvdXkzZ1FHaUVyWVZHNjZqRGho?=
 =?utf-8?B?SXYwZjBuQXlXUDl3Y1QzZ1hnOFVMVEhzQTZrcjM4V01RSGFTRGJ3M0FUcHRk?=
 =?utf-8?Q?96bJyOqDRqi1dUZxWjmvrRU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087c70dd-4d9a-4edf-a84b-08db5550fe37
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 14:30:55.3304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+l2QpazT9bTEj3SLSw/Tqdmv5s6r37cqSdr+7j7tv33mth2bIhpfdJ4kFzF3oGO9+eBq8qhcI5Rfxvmg8D0Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

DQo+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1v
bmRheSwgTWF5IDE1LCAyMDIzIDY6MDkgQU0NCj4gVG8gYmUgbW9yZSBzcGVjaWZpYywgZGV2aWNl
IGNvbmZpZyBvZnRlbiBoYXMgdGhlIHNhbWUgbGF5b3V0IHVuZGVyIGxlZ2FjeSBhbmQNCj4gbW9k
ZXJuLiBUaHVzIGlmIGdldHRpbmcgYW4gb2Zmc2V0IHdpdGhpbiBkZXZpY2UgY29uZmlnLCBzYW1l
IGRlY29kaW5nIGxvZ2ljDQo+IHNob3VsZCBiZSByZXVzYWJsZSBiZXR3ZWVuIGxlZ2FjeSBhbmQg
bW9kZXJuLg0KTW9kZXJuIGRldmljZSByZWdpc3RlcnMgYXJlIGRpcmVjdGx5IGFjY2Vzc2libGUg
ZnJvbSB0aGUgZ3Vlc3QgZHJpdmVyIHdpdGhvdXQgbWVkaWF0aW9uIGZvciBWRixTRixTSU9WLg0K
SGVuY2UsIHRoZXJlIGlzIG5vIG5lZWQgdG8gaGF2ZSBjb21tYW5kcyBmb3IgbW9kZXJuIHJlZ2lz
dGVyIGFjY2VzcyBvdmVyIHNvbWUgVlEuDQoNCldpbGwgcmVwbHkgdG8gcmVzdCBvZiB0aGUgSmFz
b24ncyBjb21tZW50cyBpbiBzb21lIHRpbWUuDQo=

