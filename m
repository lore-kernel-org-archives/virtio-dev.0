Return-Path: <virtio-dev-return-13894-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194AFCD4942
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 03:43:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 55D832B016
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 03:43:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D056986688
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 03:43:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 100E6983D6F; Thu, 21 Sep 2023 03:43:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F2DA898667C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 03:43:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8KUlh/tuphN6I0hV5udVpVKUBrTN0sjTaf8gcmM8SOQckeH2wseLzrJsO9UzJu6wHzSaV5jn0w1/SGjfZ1d4ot3umXuyLfk7pAi0OdBAObo4/gsd2L99Potz3Fs4EecFAJ4Nyol5mFV/FzF6tLXvEB+eqIE8eVcgL+HwNlJ53ZC9hdjB0WW9JiDvluGP0DuaRKiaw2rvsnQz9YfrE7ZJd275FssCFPGwz9JEiFEYe24f/T9DWgYJhZFZssZn6Yblx20UCFpuywf2C9IsPc6VhIiCbZ+ohYHi3s2+VxGaHmM09F03ifPah2bbKEoGbegQBdTZx0SgF0iQchDTnlfoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Bu3OIYNdtaeZSD9+QRblJjPybaEIsBEbRI7wSISTmk=;
 b=a6pg0ZzMrbCrA3N/vRtkeJkXUH5z3TcmKiQBFhYIa5EP0CCFs7VrlQd8BBZQA5hBu0EE9QN6Jdjo7xhF/Nq+Q+VrEFHFzwOCmo2EJrVoed6slbFPf9NYc1ZVeKzz+r0JkbA5je5rqfonO+2xTi2PAEbYqJjytDRRF+OHyOFxokrLQpsFhr/sst6L6hy/bemTOnZMSDjwHpx35Dq9+tCu/df50IExeud43SoI/hOJDodgt3Lag7gISQEDq0RmkC3u6VZycToMDJiZtkTbZvtWW/9spk2uHvdP3AwH9wgNw2dX4B5u9YFEkqjWqcFOJ6lIwp8AR2M9yGWBwTPOpCn1HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason
 Wang <jasowang@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAAM9QCAAAwSAIAAChWAgAAB0VCAABiEAIAAJySAgAA6DQCAAH/8EA==
Date: Thu, 21 Sep 2023 03:43:12 +0000
Message-ID:
 <PH0PR12MB54814A89793CF796412D6A27DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <20230920084058-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920101402-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816F8341A77E63831316DBDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920160218-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230920160218-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5079:EE_
x-ms-office365-filtering-correlation-id: cf83566b-7964-4a28-db22-08dbba54e131
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jhq4wi97KW86eSrGxjxGvcPKNmP9PZ9FIK5tI+6JFTDIbFuHMJhLB+td2cYZLZ42qatXsASuakBBSyXLtYE6w4ksjbwQh+57c9qwlHNEdizGIilul0Ogt4OcRosFArblCqdF2XWAxH4E0jGPQZBfbJirvI6Se+CAPfnOZ5bmxe0tFsfggrIJTQd6hODzhk0EGjZbfuZbrpzwy530dJOz9O/BVk+H1OqE5TGdvlhYIeKeSz1hvVPl3pelaXBy2R5cWCrfAm59uVsrTaiHxqo2QAo49IgRSBlvCSFdqghor1ZMuWEQ/srH2LM87X0Rl17TwG5xme7Kh0i4SHOP4swzRdOCvCrvH5JQDb6s6x4JmWuES1ITzFix3xvSPpPZL/Ih8EfgB6po84WhiI6tnpB9Ap11f+aSDqFu3gMpLWWFMujK/hy6Cm07hQtwqmaw06grSJ8t91rrx+aoofdu3+FaQ4qqkek6kZH6xzUNbloMhoMobC3c7XqlxjFZFF4ypcLKVVgnSJxvXCD7HitNl6uY1pZDZo21z5bizmZt6sQl/cifx+o1cGdkjn97P/DJpGNCZciwu3KqZWYhcSiVxC5cdhFTVLkx8cjG/ecCWrut53MRW8GS2h+Bkn228i117bgj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(1800799009)(186009)(451199024)(478600001)(55236004)(9686003)(6506007)(7696005)(8936002)(8676002)(52536014)(66946007)(76116006)(66446008)(64756008)(66556008)(66476007)(71200400001)(54906003)(6916009)(316002)(5660300002)(55016003)(38100700002)(38070700005)(86362001)(33656002)(4326008)(2906002)(4744005)(26005)(41300700001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?auWkhKCCOQdpL83MhHtBn1yXlyBiLk0W2wHYmlbNnpJQaJN94J6oybMQNvFc?=
 =?us-ascii?Q?kHfFY4hX+WZg0GNN2hTKQ9OsTXGewa0N+Xqp+qzOsOH28ORtsAE1LImaDZjf?=
 =?us-ascii?Q?CZpsb+eEGJ891aaB5SEW8KGFMJFxK9E0zIaUCgyHNQU8twcEaOotPdfRDM7+?=
 =?us-ascii?Q?tb1h5h/JkvBFPkrEDdKcyepH1Xp7BBfFA5OOpwJzMrMagsxCpvay4Ot4dSEW?=
 =?us-ascii?Q?MMrWpZ0PRUA+z2VE5Fq81IB/H7lOuoFYC6T7+Pd0E1kUduCR7VtT6gduHbCj?=
 =?us-ascii?Q?KZ4rmHqcex6Odd7/dDicPSGPzoqyeN+tocZd9W+VkV3y2T6qx0vfzGAspARK?=
 =?us-ascii?Q?S9f0K/mj1PyBk1QSJqNZji+NVFhHuT9J6u2J0lhL0vgtuNmOxuJxeLHmtqIo?=
 =?us-ascii?Q?LZ6dyCoqG44tA7v2VR1uUICUukcXJTDqmdv5GFcl1X3XA5qMh+5vPWTNBXoY?=
 =?us-ascii?Q?3JzvzCbdnC9zGdAXePJzItRNmmBjzfTsbCZS6zJXrMOxlTnIC2XxEPcQCXC9?=
 =?us-ascii?Q?0YRSJkU17eWDaqaPfBoyd0STmRIfiIeKHqE6LBBy+j8Yv5arNQzMXX6aRZTq?=
 =?us-ascii?Q?P0z3VYk+3KzPrqkwq6hnBFEYjpxE01DB2MSecJcy1tUIzeOH8iGr+WHgReXX?=
 =?us-ascii?Q?XoNpfEXghW1/iG78SwW32hyrsBAWmhbDjYkexe+44p4esps/hOaKhoe0pAyz?=
 =?us-ascii?Q?g6uAyMyljpRPHJvuJAz0CBAUKLF+TD68/ZOGjZK7Rx1E5072ucmr5cCYlJts?=
 =?us-ascii?Q?ry09nYYcajGLoWUf92TuI3loezpJcDCe9Tsm8V+d5Amliki5svQM7J7s+xV+?=
 =?us-ascii?Q?/Zj+Y78lOdipuFQOzbJrNrQlb7bAxhhouKr90DVlYs+l54m5b3ZYS/dMWCdo?=
 =?us-ascii?Q?NYOyUfEW1uRkoeOiUys4ZrDFu3nUW1PSnrguslSw4FUs7q+aY/OxbLon4hi6?=
 =?us-ascii?Q?rh0vAv8D20dttH+1mwnxIn65+dz6olrS/s+6nk1gjwuPVGQTgRfIBsQPVao2?=
 =?us-ascii?Q?urDaM53J2xKpl0KPZVQhfaevPQ6P4Z68mlnL3/TRRNyMG+Y2cc6MFVT7n5ov?=
 =?us-ascii?Q?aaJtcXCZ1aPvFiMWdGehdtU+0V0NHCPaB3HyTlEClSAcllk1me4/0r+QxPd6?=
 =?us-ascii?Q?jXi2CC57svJJun1zj5/oUp5bpAA10GuAZT39JRkv8X63iq1rLLgBvFXznYZw?=
 =?us-ascii?Q?SnC5Xqt6fMPQHMj77wD28VkbCF/XMf8M3NVTKgs6vHbdipvyV0VTcnlXuw0s?=
 =?us-ascii?Q?tuURoW1x5t6woa18yEOKw7ZppeRow/+nEqKuoDY72kvO2ch9uk17EnJtJ2Nd?=
 =?us-ascii?Q?o1tYix1xJEMEQm7IbsW2T5aT+T3A4G9WBOsFKaJ2pFybBIXPsMd+Ijdxsou9?=
 =?us-ascii?Q?M74ip4r0xHHrKp9o5FnVOMWwjM1Zm863OcJ6H46zfN0kgzek0w2aEpTGXeO9?=
 =?us-ascii?Q?mkh2nDk8HItY8RwtNlJ5GWcgEhApkH4RJxcw2YK9oTLEQ27k2pMdj2OpARH5?=
 =?us-ascii?Q?gqaIB902Uvxg9g+VJvAaWovpglpWOcPFAK4kk1GrcTsVeUuTokU1w/VS/Drv?=
 =?us-ascii?Q?8u7uxhQKYsNe2BlyeYs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf83566b-7964-4a28-db22-08dbba54e131
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 03:43:12.0834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I0jFdVdhJvkN666pkMxks2gRrR0nCbYQ38t9Tgcw+v7CCppqU8uopYu8fDKoXCGohF9b+2uQvXs/J/PMxrIsJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5079
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, September 21, 2023 1:34 AM
>=20
> On Wed, Sep 20, 2023 at 05:21:52PM +0000, Parav Pandit wrote:
> > > OK so with this summary in mind, can you find any advantages to
> > > inband+mediation that are real or do you just see disadvantages? And
> > > it's a tricky question because I can see some advantages ;)
> >
> > inband + mediation may be useful for nested case.
>=20
> Hint: there's more.

Can you please list down?

The starting point of discussion is, there is passthrough member device wit=
hout mediation in virtio interface layers.
How shall device migration should work for it?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

