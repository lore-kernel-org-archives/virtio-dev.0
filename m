Return-Path: <virtio-dev-return-11979-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5CCC6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 16:32:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B942129FCF
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 16:32:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B26299865B3
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 16:32:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A6D2598658B; Tue,  4 Apr 2023 16:32:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 929EA986583;
	Tue,  4 Apr 2023 16:32:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAUDOjXFad5i+vKOZk+8bG26X4q6cBTOm3UajZqxrFcSrTD77jwz/PzHtN4WR5hkoKN2Tz2foE2ulyo9JRGPDUJEh3NNFNgLSU6Jmwhll9NOmRtdZBnu4CTXBwpxI3kirgNmBrZ8icE73dX2pS037X6IrWbIBKVT7sE/hHx3Idlpm8GDDIRClK9n86qdATfG2uffgZ4GEYnaZzXAPo4PQ0f1mX0yeABQLxWdU1YDy62Tls6ICr5CgkdHKc+DaOHzosKrM6vmdsesAHzO6w4JvML3OsLLyMBXr2vTLvWBhFAqH10K1a/Dtdi5eoZambH1LuEhXMguRGW2XNY0spZJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHfYQunqFMFgQ9/piTtV1fctFmwgA90UsYnJunzqXU8=;
 b=TSl0g0T0QvWIqMhHWG7M7Iryjq4r+TJ7pedBg4Th4pVsiESMzCt1b948KiJVVGR1V4TsUOai35qFnjxNWVXzCJqLf+6102n9ufrdZevZb+Wd2lfCkMbeIN8t0dCfpU08E5z06qZcsiXuiJpLgsfk/k5vn6MkUR26Ux1LTrbgeouYATXG4dJCxyrD3Aeq4hSlDDqA8NAzbuZ611Wim60go/+Z/RPQUAL/sLBZkn6JuRdTmVh/4f9pOKTMSD54SfVd47cqNvfo3PM4HEl8WHNJ9b2fABCHBj+fEEZg7U4Y6D8LJdLzYYcswd+qkGJpBolg0qFNZa30gGNysBzh3Scfgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Halil Pasic <pasic@linux.ibm.com>, Heng Qi <hengqi@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Cornelia Huck <cohuck@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>, David Edmondson
	<david.edmondson@oracle.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-dev] [PATCH v14] virtio-net: support the virtqueue
 coalescing moderation
Thread-Index: AQHZXZuPSkHzCyhNe0+TG2u8UyOq1a8bagWAgAAARvA=
Date: Tue, 4 Apr 2023 16:32:07 +0000
Message-ID:
 <PH0PR12MB5481969DB61A7CB30E89C3C4DC939@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230323152422.113103-1-hengqi@linux.alibaba.com>
 <20230404182925.349d402e.pasic@linux.ibm.com>
In-Reply-To: <20230404182925.349d402e.pasic@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB6763:EE_
x-ms-office365-filtering-correlation-id: 0a9a57bf-78ae-40e1-5c7a-08db352a21c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pBdxtui15T4st0AJ7vD2y8nQpt9zSonlmS460aUVNQ0ZSBOIW5KuhhQD8yhhvDkRpRCad/Ckuyygi6wOnO2oIf/1oXxkCqjOtHaS1whODIlZtqEWq5ZKr6BefBQFUK8g2SvTvq5PRGhgNq01Sh9n36ltIOWN1Z30xGCVe4Rf4pYKVG3JUZ7VLGS64f0Mekvf3wdMOa8YpSMKND9RBhv1S7NZro0hfekEIsGkyOPMipu/IdKHlCcQ5nYe1Mu+MeyVY7o9snVCseBlu6Tk3ZPfBeRfXFv0pGoBfKjAgJ/Q1kyn90Yl7S8uaWUS/xf9O7FzXXsIBzR9CKITZ7G7lA+Vqzb6WUYOMvjPeVg+G4nJLq/0RLvsfyrKav7D06o8XfKpyzyT58UEWYoP50ATo7HW9d8k2KVOynhLjFYcfSq5er6kcnmir3nHxgtlcagTbRk56PUXi3ru5poy+TIgR6fHlmaaNMYeeM6kgX6ERDaxJiZ0cHfD/V23rXr3Hj/d43SXVXzQVGB37ANMjbti4R+fj+lq3O/ZxhOfyIHoNqJ8CL6A1C1GZ/K/fOXwV2OXq0nFnLo6w7hleJlEMLSAEHP8MMGv3Bx1URGqXI3ANDp22zB+BeY8vbFku5fq20KLRBSH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(316002)(110136005)(66446008)(66476007)(64756008)(52536014)(76116006)(41300700001)(8676002)(4326008)(38070700005)(66556008)(66946007)(122000001)(7416002)(5660300002)(54906003)(38100700002)(8936002)(478600001)(86362001)(2906002)(71200400001)(7696005)(26005)(55016003)(33656002)(186003)(6506007)(9686003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4+kCbVTTpUlA6o5KEBca6hV7/lZqqQFoXjxeQMg/bOGneMMEaWwMTc+WeKxA?=
 =?us-ascii?Q?1Q/Gf0u+6x1RX7D3vyDWR4NZAk9LR3s3K1A+YncFb3Xcppgg09OP3vlx1TEB?=
 =?us-ascii?Q?YKmFlFvFQ53cBJqvv9wCdepxMAU3m607mwz4oUrKq3XWNJf1wP2JnQcEtyMr?=
 =?us-ascii?Q?HwvJNdKnVPo6HZGCKhMvngItiyuDTO7UbzNN/kM4DKAs/6j44hCmJNyJLgsp?=
 =?us-ascii?Q?YUhcNErQ0dM6NEHhsrv3nhm322gOOqo7s0G2yurmDnwoJG+gysoFtstekbQN?=
 =?us-ascii?Q?wMtrVjnCzqC00bsqEs4V5pbhOlceYpDC3tflFoj2mRNy5YftZ5U4LLBXyuSN?=
 =?us-ascii?Q?Wg3YbkRaqe/8GjsJhLn4mFIqTVkddoTEaWxzfD6vPHxdV7u1quhgjDb2jQMa?=
 =?us-ascii?Q?RXEcZPljW6iSUBOQzaJtg0DXSqvZ6MvtSIV0cHGp6FYRlg1xSul1g6fBwTHZ?=
 =?us-ascii?Q?FF2hC7xgtSLSfM6ROCbO1/8P/pvZ3NvlQ3MowN2AAbe5pu9T/zDCYYTRWogg?=
 =?us-ascii?Q?7LQFiTJqpi7mPOTQbHtjpnoOWqUaOct7cEcF0Yv5C51hm95R5OQfC+7VwX0y?=
 =?us-ascii?Q?19qG/kE7+6TLaynkzImfB4Fecig5M3D7MMzx1UOsB7p5jWr8rzNMcWUh4lUm?=
 =?us-ascii?Q?wE8ApW3ifPJEkhgedcQNos/aFSlSj/MW+VrIU89smeZKLm1ypJrKarztiCbe?=
 =?us-ascii?Q?6BrnGSt+xCsl1NOphQ/rIElyZZATy4fczge5KPNf46AgmbT/HjyslOoz0sGU?=
 =?us-ascii?Q?tHvgWwNwT2efwmk8XuLGfAdlmOwQH+wqgDUEc0l8WV0R4I7SD9WSx1h2UMF+?=
 =?us-ascii?Q?msrXwY7C4ULnSohZRDqk9SmVba1ySRcEYCSP8VhSG1tChwmFwNPqfZ+I6XYF?=
 =?us-ascii?Q?WcXZebRtdhHkd7taYi6zbrNOYlpwPsl2DKbkujFV3GGvEx4NZ3GTRwWEFvRe?=
 =?us-ascii?Q?2GJV4QyJGoXmTu/uSq+kg/DS8xWkR2pwWhTYrqoGWXBhIkU7Rhyo9DPCdzKG?=
 =?us-ascii?Q?LoWDyAUYKZSwmLP1X4t8jOXxdLUmUVdik1ZCk1Yf73sdFB4PT0TIzk3tI9fR?=
 =?us-ascii?Q?7aWGWoE2cD98H0kOD/Quu3JNSNEfEeOVSWBEdFrrj0gk3eR+W6QD+gAuMXg6?=
 =?us-ascii?Q?+UontQAT6jBPBqncHRnGOgT8kRo1cARG7tuAvonesaUeYtJSvX3tgnLTsObv?=
 =?us-ascii?Q?6jsvgU/gjgnVCPNYTBjVvWvHxZ4W7oTyBC7Pz+aP6tbxG9AW+IrIpx2YO7M7?=
 =?us-ascii?Q?w8kYYTXN3SlIqmiL3VLAker3NxrU+G+hENR1qfNjN7BNb1nwNRVPfw838EGM?=
 =?us-ascii?Q?XHOBtJBW+cBGbWlF4tGclAaiEx68yl7h1NTTsXKZunbiOYB3oicyfHxvxi0L?=
 =?us-ascii?Q?BFBJrIYDsXa6EVm63Ylx3Wdn85VGUdCHYXRpO2d1rPoCPK8s0yQOMor+C5as?=
 =?us-ascii?Q?daU8OiN6Tas5NqAn6i2xT9sY5yMgDrhH03jvHsx7hzpVg5XufifT2QTN6NOe?=
 =?us-ascii?Q?qEWiQ2vG3ENtAQ8l51acs/Ym/Mc+DDZQgb9WGR9P3Ihh/V8/JlAYJIa3fSlj?=
 =?us-ascii?Q?5fQT5XdwbNbxHPvokP8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9a57bf-78ae-40e1-5c7a-08db352a21c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 16:32:07.4495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQmC0HMWSqbyPdsqXwRHcGHfvGxlEbXL+CgD3ahXVKPSEBEFqr+GPSSG+9Q/8npS30DwbWAnOh6nFWV/utw9zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763
Subject: RE: [virtio-dev] [PATCH v14] virtio-net: support the virtqueue
 coalescing moderation


> From: Halil Pasic <pasic@linux.ibm.com>
> Sent: Tuesday, April 4, 2023 12:29 PM
>=20
> On Thu, 23 Mar 2023 23:24:22 +0800
> Heng Qi <hengqi@linux.alibaba.com> wrote:
>=20
> > +struct virtio_net_ctrl_coal_vq {
> > +    le16 vqn;
> > +    le16 reserved;
> > +    struct virtio_net_ctrl_coal coal; };
> > +
> >  #define VIRTIO_NET_CTRL_NOTF_COAL 6
> >   #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
> >   #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> > + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2 #define
> > + VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
> >  \end{lstlisting}
> >
> >  Coalescing parameters:
> >  \begin{itemize}
> > +\item \field{vqn}: The virtqueue number of an enabled transmit or rece=
ive
> virtqueue.
>=20
> Just to be on the safe side: VIRTIO_F_NOTIF_CONFIG_DATA has been
> negotiated, and queue_select !=3D queue_notify_data, is vqn supposed to c=
ontain
> queue_notify_data or the number/index that is used for queue_select (I'm
> talking about the PCI transport case)?
Vqn has zero relation to notification config data feature and featue bit.
It is the real vqn enabled via queue_select.

Once the vqn is renamed to vq_notify_id, we won't have this confusion anymo=
re.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

