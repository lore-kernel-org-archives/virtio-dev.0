Return-Path: <virtio-dev-return-13719-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9FFCA0ECA
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:41:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 113D32B010
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:41:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 087A79865CE
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:41:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F09CA986485; Tue, 12 Sep 2023 10:41:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD32F98648C;
	Tue, 12 Sep 2023 10:41:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1uJ8b/9WEAsqFWecZ8FZ+FB8BxYQr+DSOX+zoYE7J2+qISO+iDy8a0VnUCGlTQxrW1BckHANcYlGI+g/gbRjiXVasK/WuQEcXsIZF+KHaOjQlE5GhXRA4UbAtrWP9M1SmKNhS2ozi1Gzi8Tsici1h+vJzEDR2FTkNQbIWXFaqxSTXU2hbKeb0z9G/EBhRoaGjPKTC08csiI2mip/VXL1KXLLBDXHtbafqec/nB06Fwm6VRYxZ6Uaw1v2VjQSh8SLmaL61a3gPbKbJARsTr3F97pu5Gf0M05e/IRkS9EU2ij+xog6kOFUknjAV5g6Fncjdf0oInPqzKu4Ai4Crk9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN+ZtF52zQQIHg4Z59Yy9VMMK2pkPhPSwFeue7wVlz8=;
 b=ZCrYDeVb1cYJ41uCEZi4QLiLfMDfcuzIn+iAo3luPUdhO39KAfPufHBG9l+VoWmz41K4BMcT4S1rl8vue3BkhhKNdIjg4j48OoNmwegXFIZ59KoSFwrTf/6dDoKj6CnCptczBM4SKEbGNsSXdEbcYjAD4kWGAW5Xsn0qChX3jLnUlfQSAxlfZrTxJVlVX3WZG/n4s/WIarnHyp4kvLP/TA+uwogj6Jnbaw1buP6J677U/bpJr5oFR0IN7ZZbOj2yreCRtCGJUMowmLpMBVL1VN5FiXJYnyNHZNBDYfB8MRzbJgefYc6kooZi/eSpuMgB6x6ke+qIHeV+9/cfooqvkA==
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
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAFrJICAAB38cIAACoIAgAAB5TCAAAzeAIAAAVowgAAud4CAAABSIIAAAeaAgAABfOA=
Date: Tue, 12 Sep 2023 10:41:28 +0000
Message-ID:
 <PH0PR12MB54815711322F1CAC35189CEDDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
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
In-Reply-To: <85b1670b-5094-cdb8-fde9-1a9c0906f094@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB7310:EE_
x-ms-office365-filtering-correlation-id: 6b3b2020-dd20-4954-c511-08dbb37cd206
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QIShPEeA+hhu1n0uD5rSSSRESEq1koKM7yJRmf0RJL30aBWyb0KySI+vR5y+AEsXcYSMGHsjpspv4hDP4Ti8vE4A2PGFR5H6RquWTeBYpelS06F8ZuVEEYh1cMRsaVHeepZceiPGLU4WHMQWBYIQA+hNBNc2uUEMAJlu7kzQJW/APi37jstjXmV8V/IF7Wpi7CO1fczN1qmcx+IiYlrHzWacFvPuUep2hGGI72dOMiAyJXjlu61jWHXriCXSghyrYDSoOX5DttfpQxgffu2HqWMT9ASfe2hjzR+C5Pd+uXCvcZ7QviE3j2NFWTW0uLr9ofG89JX3q163a/m3AjGbKpdDCQyOG2/Hext+PAhsc9kFJmkFe53p8H2AYSFZ7quErUj0J6Ggr6rXXkxL5teWKpRbKxVnFB81H3bc2pksMbSfi0+AHtJ1T61zWUtbF121SJMYn6WQUVcRR4sdjBk22M9DsmQbdTO53T0HBdh6OcgwRwDISX1+yO6s5CPrmCiPOSr1O4LbXPgqx/WZ8+ckt3U5iNwnhXtDTUlwpFy4H5fWTNyO0C4kL4O6SASlJFHz5W03JwhOTOk1f2tNMnbdbEkvXxiR29MvD7bTQtGiD8Iw4m8qBdytRTngLs8pSb0OivQ8Y7ql8jpoW0LT/rwFcQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(1800799009)(186009)(451199024)(9686003)(71200400001)(7696005)(6506007)(478600001)(76116006)(41300700001)(26005)(966005)(4326008)(66556008)(2906002)(52536014)(54906003)(316002)(64756008)(66446008)(66946007)(110136005)(5660300002)(8676002)(66476007)(8936002)(86362001)(33656002)(55016003)(38100700002)(558084003)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bW9wVzk3VVpIM25BdHFFcVZvSEZBMkhKbkRuSDRaQVJQR3A2b2UzY3J2MGVq?=
 =?utf-8?B?NEtIUkNqQzUxMTUvNThkT3FSM0dEVkxyNnlWSFVUZVRsSEdKSVBMTEhGbVhz?=
 =?utf-8?B?MWVSZlZMZzh0b0VIcnFxN3lkUW9FUyswdE5nOWl1bXFCeGIySEdDMUhGQ1RL?=
 =?utf-8?B?eGRISUszWmxETE1HZ3NjaENxdEVxajAvS29jTE9iQUN4VXFhN25lbnQzYUZJ?=
 =?utf-8?B?TnBGeWdNa2p3czg4bzNzc0JNOUNuejJmTDlmMUk5dWhIbDhaTnNXTnVHQVBm?=
 =?utf-8?B?VTI3SDVsRUR6STJVemtDZXBuWmlITlVpbXF2d24vNktCdXdHUG5vOEZ4R1FJ?=
 =?utf-8?B?enpydGR5cmg0bzRWaE4zV2JuRXhXeUFIZll6OGdoY2NMdFp4NFE0OU5OZWxF?=
 =?utf-8?B?T2xFRmhUcWo4dW5GSDVLNVdHYyt5cEl1dWFXS0FWYTgrSmJWRFdkaXkyeE5v?=
 =?utf-8?B?TThhbDI2cTk0cTNMZmJjeVNtOHVEMWVaNWY5OE5laEE4bHVsRGpXQmpJd3hn?=
 =?utf-8?B?Vy91N1ZzTCtGSUdlOGZYRFducXZiOGsveTVlLzNHL2hBdzFKcHhkZStXNU93?=
 =?utf-8?B?b0pxRXQzbk93N2hlZCttcUJzTkp6UHVlRWdsKzFBb1RHWi9YK1RzSVZBYjAz?=
 =?utf-8?B?MncxVUFydFRJbXRwamd4Rks0VnJKbllCSjlGcFc5MjQ4NHpvcHpZaFRIOFBz?=
 =?utf-8?B?aThwc2Ryam1DYnRrOGtlWjg3NDFrUGszTngxNVI1UDlWd3pvUk45REM5T1Y3?=
 =?utf-8?B?bW93RzE2amRJNHZwaHhQSGNYZDd6eFZGNUtadWpnWEpXT3JESVN5OVN6RER0?=
 =?utf-8?B?S1Uvbnh2eFdHVnNtM2x6czhtM1doZ1hRamRtUkEzYTc5bWJDeHd5MVU1OGJi?=
 =?utf-8?B?Y2JpbDRQaUxZZWpsS0FOcy8zakdJdFFZL2MvRHBnMHppcS9TMGMrNUNzczZO?=
 =?utf-8?B?QjY2WWdpMkZsTzFNMUhCaUp3RFpEWHhzamllTWV1cEE4YVNWYW1ORVNxcWZ1?=
 =?utf-8?B?cDVKci9vdzdqWFB5Z0R2bkJoRVNPZkp6UkRKdFFOaXZYZU9QVkp6MzQybVRj?=
 =?utf-8?B?ZFJHVDQ4YXcydUdJTVZHbTdKazQwR0dydTVXUDJOUFY0ZGpSSjl3ajI5dDZN?=
 =?utf-8?B?UTd5c0ZEaVFLQVNTSTFUT0VYWTRvU0svVUxjN1M3ZXV3U1h0UnIzT29jNUNL?=
 =?utf-8?B?TXQvNHpIRmNGSFZ4dFc1MjhMZFc3UlJNcjkvUzZOdE9uemFpeGU0VFFIMERT?=
 =?utf-8?B?VytKWGZBa29pTTN2c2ZmNGFmYVFjSWY0MkIxYURteS94VDgrOXNhTk1mNE9P?=
 =?utf-8?B?S2NuVUliM0Z5R3E2SlFaa3RHL1V5YzczVW5qbkpOV28zRjZOV3FhenZGcE95?=
 =?utf-8?B?NE4wWDdlZnRDWE1iMndoVWRZNW9ETlkrK3MzRFlGaTdKSXNydWFyTk0rOEdm?=
 =?utf-8?B?Mi80YkluM0xvNGxXY1pwL2FsT254Uzd1SElOWUhiRmlkUG9NNW54RElCUFlT?=
 =?utf-8?B?eGNBenJBRUpFYmZZeG11S3ExeXlvMVM5QzRkREhtY2JRQmtEMHNEaCtEbGhJ?=
 =?utf-8?B?RmZ1NEt6UGJjN3ZhS0hMVlVMdGtaZE9IZkRwZEo3ckp2aFVTbHc2K0VqNWF5?=
 =?utf-8?B?WUpkYTNqZHhlYk1hVkNtcGRWTm45Y1AxenhheVo2N2trWGxrWEhIc2Z4L2N3?=
 =?utf-8?B?ZHFvTU9uTXM4N3p3N1hyWXpxQW1EZzd5VlExNkp2b1VjT0t1aS95RGtpTXRz?=
 =?utf-8?B?QlJ6VmdPR00rVHROWkxQUUlWb01XU0l1dld6RUU1OGt5V3pJa2oxdTRVVFdU?=
 =?utf-8?B?VnNSMkswRHlsR0NUWkozQ3FRS3R3UjZpT0JocUVCZzdoNDYrd09nWnZMcjRM?=
 =?utf-8?B?U2JiZDNaemp6eWk5dmdhM1BUN2JCOXFKdnhtb1ZVRFpvWXEvM0luK2crYjJO?=
 =?utf-8?B?aElJczd4VGg4VmRITzB5QXdGR01YQVVoa2VYWWxnaVp2NkZkOVdNeUV4TlVG?=
 =?utf-8?B?bkpaRHpPY3ZkeFFDcEtpWXNvZjRtaURleVRJQXZEcjI0NkpkOGM5SnlpdWJx?=
 =?utf-8?B?U0Rra2R0ZXlVR3RLSG5zWTF2RTVTWndPQlAwaXdCTkpYQTFoZUdwaHpFZHYw?=
 =?utf-8?Q?jPQg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3b2020-dd20-4954-c511-08dbb37cd206
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 10:41:28.3912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W48kuVg2oWxM0FVbuK94J73PXFd8fstMkzrQEQ7vAJqzdkmFp2lE/IMB+GV7wGOozXXWYo56JjKnXsx2ti/5eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAyMyA0OjA1IFBNDQoNCj4gSSBtZWFuLCB3aHkgZG8g
eW91IHRoaW5rIG15IHNlcmllcyBjYW4gbm90IHdvcmsgd2l0aCBQMlANCkJlY2F1c2UgaXQgbWlz
c2VzIHRoZSBpbnRlcm1lZGlhdGUgbW9kZSBTVE9QIHRoYXQgd2UgaGF2ZSBpbiBzZXJpZXMgWzFd
Lg0KDQpbMV0gaHR0cHM6Ly9saXN0cy5vYXNpcy1vcGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29t
bWVudC8yMDIzMDkvbXNnMDAwNzEuaHRtbA0K

