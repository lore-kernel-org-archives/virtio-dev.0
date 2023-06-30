Return-Path: <virtio-dev-return-13188-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA36FEB64DA
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 11:14:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0F7552A8F1
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 11:14:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 07E25986722
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 11:14:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EBDF798671C; Fri, 30 Jun 2023 11:14:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D4E489866EC;
	Fri, 30 Jun 2023 11:14:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L49X1OcISI5lsRKLNs0u4sf5FGvmOc6faveOHxyZ4oHsP1SVeLFYCAwj/YrvPXchdrVjj0bRpIHIwmsrZK/+Q7d0LKrYFfKkM8AWFvRQAAkCbpbfHVARvUwHJxj8jZ7zgCwaA4KKml0nzVEVqWjmNwVru576DqRiL9IWn8cCG0uMigcGjIN3RCv6RHD+44DpjZHGZMttU/JF5OvvBV/eCOKGUD90X1fIv/ZTWM/Gi1QGwOiX/cvn/zJ6oQ/+dPVLyTR6GoKZVe4DXa0YUWFhf8M3Rv0ifwlfj7MfPY8QL+h7084x+GG0tpzPbEa8BzeMJj+YmIK5cQzbQnA7JH94HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=is0UfthPPzPDKMinay9i+HKpiV9Z0yd2bDJXGDHX5yI=;
 b=j+4HPiefYjDrc6/ZotpSM5OUe2GBaNofmU15w96Y/h0g0pSFGQNKX6YGgTmq/2WZ6KWPUKxPfiXlGPPoIcIFjlQx7GZKF2y/FAqUdg/eQr27nPBa+PtdwoObJPIVfhddQCBYURufH9xxWhwRF8ohUvkogS/rZa8u50YUUrVsJONoUddbz4B4XAXqD/z0dl1CIk6YqLI6n4gkgyHon2D+uOR7odjpX5sujN+ZIT0tFMaR6nyzhl+i9yeAnutxkVvQywZ3c1E3RSS1Kz/n5qIbVtFaVvDH82Tx0jWtE4MNBeCNhPliZJcOjcTH94YAndNb0nO7PxL8leKmpQUj5uohHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [RFC] virtio 1.3 schedule
Thread-Index: AQHZqy+H0b/xpulmKkGHANaS5KH69q+jMXiQ
Date: Fri, 30 Jun 2023 11:14:37 +0000
Message-ID:
 <PH0PR12MB54810A7D2229F4C97E4BF6EEDC2AA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <87edoyqvnu.fsf@redhat.com>
 <20230407071926-mutt-send-email-mst@kernel.org> <87r0spjct2.fsf@redhat.com>
 <PH0PR12MB54819136AEC54AA081DD395ADC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230629153345-mutt-send-email-mst@kernel.org> <877crl49qy.fsf@redhat.com>
In-Reply-To: <877crl49qy.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB6863:EE_
x-ms-office365-filtering-correlation-id: cb8d6eb1-d86d-43dd-eb5f-08db795b30f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 L+eCdrF2t36i76HpeQhMqmMlqLimaQJRg9rKhpr0aQtu82psF3PGyvUyYzCw0a6PxHgqlroUOqUGUMucv1ehx1ehwQU97Z2rWJh6XwOr0LX/+uYUWgB7ktdF2R0L5SqjQ/gTdKPqzmHZz2kLoRglRDQlv6RpiTb4ji2Nca2hxMU/7VycDfGzqELvwQlUK4MKohUUXvKCB0wuGwiLkXZTiBq70kz5VjVJylxygmLizReqWBbNtqe5ykXGXL3CpOGt24CEnMfmcrZ715bUwvTnAZGs+FRWA8nfCJCCetZqCN+1i86UWD477xSZXuEyJ4TwASB9JtC7990CbNLOkoARFR0hJBcD3vntjeTkhuPd4WXxf5HOXSjj+VKh+WEmDhIBYT2bT4kS2aSWQFJXuApgEolc+GvsYf9vByiQS74ke05AqK3Kz5QX6HcUYxgeET1VAfRyISNxFURT5/KO3GfPz+TmCgfg2/0IVMd3rTXzaGpH97S+0Y2N03QCcAUV8vvbbS5bZoPz3h5Y07FIfrn6lUIUlRTm1y24eqhwQ/xhqAYgfCE0uzotYCis3WJCuspWKAw3qx6B+Wj27sTbSFMPdar6gSqBOL3G7aedxOZClFJCeaFlL1imzX+jz2G7AZ+E+wQFXxYNOHsxaHen1fHwKzNf4PZHh+JCIZZkPA07/DE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199021)(66946007)(76116006)(54906003)(110136005)(66556008)(66476007)(66446008)(122000001)(2906002)(4744005)(8936002)(316002)(38100700002)(41300700001)(4326008)(64756008)(478600001)(83380400001)(966005)(7696005)(71200400001)(5660300002)(86362001)(38070700005)(52536014)(8676002)(33656002)(6506007)(26005)(186003)(9686003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gjCsXfXUDxbQWWm61XXzCg3w4qtBm8fZqSsZEc3qseLL6oDyM1aldN7ZYfA5?=
 =?us-ascii?Q?0VKUB8JyJaxfOiikVmVIUd6LtY2UxEhINfkcjRezYgMvP4sbSc4fgF6i3r20?=
 =?us-ascii?Q?/YR4HgzZvWUvbd0OL/I8ZA2rS8ci4sisDuKeMFWsHJ7xLCQ5XGaaln/itQpJ?=
 =?us-ascii?Q?VZl1+tBAkWue9j0gsgSRiTDwd4780XNDCOaQmbHwF7VspVMAPwguCWWOAZK8?=
 =?us-ascii?Q?0SAnxSUySmJg24PeElZu1Qs4eoGQowQqztaE610Y/hftPi1tAQj4FPkfnMlt?=
 =?us-ascii?Q?VJ8he9L9SRoIrIcPhOq74xJHA36N/yeUQCGZlgpwh3Iap44I6Ng13e0praEx?=
 =?us-ascii?Q?aFQMWYR0tKuW+O4qGaxIslsXJMjC7a/vCQvJuP1LXK9kdYmDu4rK7o3TW4le?=
 =?us-ascii?Q?aVaLvHZb9dI0PEFjlvDYBrjsGKT40JPyBKoFWg9sla3M4p5xhXDW+7DjMjFq?=
 =?us-ascii?Q?wfocgh5aiH/aWGYKtVhq609WPJS9FDdhFzT31G66GPct5X6DmDLSRFu0NjV8?=
 =?us-ascii?Q?y6KDXmKMcMxc8gddqtr7spR3Skslne4UxS3kpWhfwb+oYxzIHWzFxp8ToBz3?=
 =?us-ascii?Q?vlcr7UnYJlkD8KVq7lrdUCXvb2xe6vpiD3mc8oemPBIm4VU3SJAICOyGfKnm?=
 =?us-ascii?Q?do9d/oBmuTBtRTPeo8ZOithG3r5XXmhUAAq181n3Y2BRwQs1k37u/mfuv6L0?=
 =?us-ascii?Q?/xP4MOiPzlwV/pRo/QmdBtLu/q7co0bHsmbfYiYCAE16H5rCLzMcWSpDMYZT?=
 =?us-ascii?Q?JcadgkllmUrvh4pdXKJyeYL9mB/InbaBQOjPw3o8MNXoMkogd2ZsQ49rrUrD?=
 =?us-ascii?Q?qO60RSOnhD9GbEcCIwOaeFJFw5RSlTkBFBf/9NxeeOd8jLyz0iFH4PvqMrdU?=
 =?us-ascii?Q?N42YcsnYt3ifhk81w4Ns4OgvvpnjMV1kdHLpla/+ZfkQLsoBAap3in4m1kR2?=
 =?us-ascii?Q?fnuIO0oxxjMy/vL3G0NglnwqqZI1sC/uvi59sZTesrNLUW/mMdUADPZO9xDC?=
 =?us-ascii?Q?l17bl7nnMOcIcsnNdugdbbvRXZ1/QlyR9qmJcdbYw7Iha9YNtR9I6A3j4J5X?=
 =?us-ascii?Q?rDHQF2UIYSVwWGLbenjyjJZE11JkYiUfdN9ahWEJzuvqhouD0IN1vZLk39zS?=
 =?us-ascii?Q?ih5VXs58FjdRnC2oniqg287vRI7sZshRcUwiLxSb/gQLXxNjViufV0JofDv2?=
 =?us-ascii?Q?OmHhR6bcPe1wMsOv9Ony49R2NP0ASSmnlW7WiGjT78HucYiQERav7H8xATqd?=
 =?us-ascii?Q?njwBWk7T3cl3UPrhqXh7j1UG2We+GjGySR1TC7SRMouuxNVbXVKu5XYxCLYn?=
 =?us-ascii?Q?alpqcHpWKdZesvjtevxV7hh1WIs3vFtAy/uhxu/v2odHx27SMPw3r95uwm5g?=
 =?us-ascii?Q?1sy92xM0BUWlSywyWQNluo3/KOQUT0R8VKIj7FuZtmVsgbCIAA1+lWDapfrS?=
 =?us-ascii?Q?MuR78LSwyXZJR8qXQkMpcim819X0ZL+VzS/huyqThGwbR3xFh9PPN3VSV+BL?=
 =?us-ascii?Q?d84YZBjrT1rIjsAVVS16MD/I6jxvDoWUihXmDichAhi9xMCxLRruRqk9B2R9?=
 =?us-ascii?Q?xvdQ7sREA+YmLMPj3Zo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8d6eb1-d86d-43dd-eb5f-08db795b30f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 11:14:37.2855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DgJDVsPRr+T9DzSpZnSG7NwVayiKhiok1D3+G+486vFLm4mDK+9yagU/pjIydBk7nW94CpB7XjLoKqfV4UIdig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863
Subject: [virtio-dev] RE: [virtio-comment] [RFC] virtio 1.3 schedule


> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Cornelia Huck
> Sent: Friday, June 30, 2023 4:48 AM

> For the inner header hash, I see there's already an issue (#173), so it's=
 good. I
> have not followed the aq legacy access feature -- if everyone agrees that=
 we
> should be able to vote on it in July, we should have an issue for it as w=
ell (I
> cannot find one just by looking at
> titles.)
>
For legacy registers access, it is https://github.com/oasis-tcs/virtio-spec=
/issues/167

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

