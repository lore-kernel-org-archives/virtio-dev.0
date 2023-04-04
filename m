Return-Path: <virtio-dev-return-11987-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBBAC6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 20:50:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 89C9B29FD1
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 20:50:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7CD6D98659F
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 20:50:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7214D983B4D; Tue,  4 Apr 2023 20:50:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C3E798658B;
	Tue,  4 Apr 2023 20:50:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4SVkKFFcNHxjFH9pBHAwj/m1EXCTtslfmmCH5MD72uudu7+Kr4SJmvgHN9HhYaIuinYb3Y/5txfV6grRkkqXkqHKznZc5hfvywP5I4Q548XW5ypr857ctyRp6LF0vRq1tcqpjoAE5nRNCihsmdFQmMPOAJd9f1q9yZmFY3hKIIfOjn3dKpBvOjFiqJ96qznXHLw7l4IT8jl2VXdsegn7TtBpWj9/B1wgecoczlB62i2TYTWfLYVpbfd3mEe4+iUp3szEI1C86gBe6Jx7fD2svUMvlFYbeOItsguqP7H7+UH3ry7y9u7BBUOEKLy9huGOmjOdW8shSWPTEF1MNM3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58SGz4fDKEfN6+qqmpB3gDcmKr+QlSPibbtzb8pmoNI=;
 b=UP1QDwOlp4QuhUQwJizxm2IBpiMV/QD0izK1qH1K0D9yWiKUgDehuug+OGsXok+CeRRIO8OTbrTLbQ5pouk/akQeQ5wfcnwWC/cPbfi8VdJjeVAW+dpT6H7kSHQ6DcEE5EV6nnU+0debmLMMYhJk5Qe4wViHYB5NSzM6ubto1GrBpoKf5PtjJlhpYgCTSJ9chb2amMcd0vCBrjCIyTD11EcZ0EIKeFlZsFWnnR6gBzgjQ5/Lq4WAUOusJFwywy3OCs7orftces11t7AbHQ13W00YU8jns+bCwnlAdc5KJ3vYtC9azeeHb7kuU1PaHxcP1Hf/QZsktOVfSpmREOwDLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Halil Pasic <pasic@linux.ibm.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Cornelia Huck <cohuck@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>,
	David Edmondson <david.edmondson@oracle.com>, Jason Wang
	<jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-dev] [PATCH v14] virtio-net: support the virtqueue
 coalescing moderation
Thread-Index:
 AQHZXZuPSkHzCyhNe0+TG2u8UyOq1a8bagWAgAAARvCAABSZgIAAIDKAgAAJwgCAAAmH0A==
Date: Tue, 4 Apr 2023 20:50:43 +0000
Message-ID:
 <PH0PR12MB5481D95889A86A9BF9889C5CDC939@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230323152422.113103-1-hengqi@linux.alibaba.com>
 <20230404182925.349d402e.pasic@linux.ibm.com>
 <PH0PR12MB5481969DB61A7CB30E89C3C4DC939@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230404134141-mutt-send-email-mst@kernel.org>
 <c2239805-3f62-ee76-d422-2f6c247b7747@nvidia.com>
 <20230404161213-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230404161213-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW3PR12MB4572:EE_
x-ms-office365-filtering-correlation-id: ca54f570-9b80-44be-d344-08db354e4248
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kIl4Df4pKSIKytYIpKUSHXOlBtA4KaGgI4sJKxViJw+IaNa66wxzlLMFc5gr1pd49BLV8enAbHFPzrg+pPYKn7UawOOd2J0n1v+BfYnZI+b3a3Uvu01HaG8uZB2jeb33xBbAMtaTYmJrmxvZYXsyCTlVWBpo4HYTKTfmyL16k4z11G2JPako7hHuLI/ufLg5zBBQFg0C2GVg6lx2x6+fQMGxKReAOq0tWjiVpCK5HG5OQ1K3TjqZjJvNKLNI1fCb6ha7CLKmksJ5+7YAOjKL5mTO2TS+7t7RWFKd7sNC2kgkffmS8/PYyst0YaxIvm6/kkVuPJz1rpFvXoouKLtPQoSM5uodVozISi+jcUskNUkdsiVXmTCFaVxjok61gjJuPPOMLaCgLaaX3ndZTUftwr+0E+eiJ+sjOYbfKQPy3Z8ex0veAkvAV5r4tvlBq1x3GvuylzZWE0tC5kJCtVwegXkEsxETHe03fuAUPktekINwO29EAB07qizY7nZl0m9JE/r/xR8VhqCozOK3Na4O+jU4Qv/yxoD+/+AmXVyUY+ZVE8HNzYUuGzsRE2kh/fnn3WtSA/TbJX2z/c4fNNqBhOzYdNpJXH75rE1IaYVFMlV3VEXGF/XZnkuBn/qCH1JU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199021)(2906002)(8936002)(38100700002)(122000001)(5660300002)(52536014)(41300700001)(38070700005)(7416002)(66476007)(6916009)(66446008)(4326008)(8676002)(64756008)(76116006)(66946007)(66556008)(316002)(83380400001)(478600001)(6506007)(54906003)(26005)(55016003)(71200400001)(7696005)(186003)(33656002)(9686003)(53546011)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yoifL/v0rCjmEg8q3fkbM/2dJXgdW9yI1OIDxaDHOAYpNAehkgs7tCUqj3x2?=
 =?us-ascii?Q?WRICmJbI5irY81v84XxUPvQ1bF7Gef2KtNNF5R/KGyzANZzlqIsCnlOusj9D?=
 =?us-ascii?Q?R1jrg4p1hLvUD5ckccHt8/50THXIE34jWRnlIzf0RyG83SV/tCCG5+0Ot4O5?=
 =?us-ascii?Q?h0qu6D9GYnxw/MCPlwwLzb4qwc7sW0/jwflO/YKenyQYr9L8dvMCGaetHDGR?=
 =?us-ascii?Q?zZuhciwFtTpwBLh+KkCBRfnI0HioGUbx5cLWf8+4+JLsPrTyhYxvLy5eNHDj?=
 =?us-ascii?Q?id0qsAKtwMjss1FitZ61wbZ/2PoB9ahPGPZJoQ6iCcs2CFyFGw2Xx7d6AybN?=
 =?us-ascii?Q?lyULUOEvI09TbJdRZj4I6LCwtwc6kaWFsS/laGEPYm3iwnlethMEn03v8j8f?=
 =?us-ascii?Q?OkkXxGKcH1z72vhFrYZ5Khv9JvFqAYyqiMvIzH88zfGBzJA5HQ3zPTbQQdyl?=
 =?us-ascii?Q?at95LxtySDpe9a6KRFdmwhIY9QD7CLSlV1GAgH/1j2FRJpbhHiMX1IVidUdP?=
 =?us-ascii?Q?+YSPuJwYwETctysc4du24MAVZFhbumQfbI8Dcb0adwCcykdMGw3FdglhWx2w?=
 =?us-ascii?Q?GYlfhHn9ujwpKQZDnlCOZfBqKvQeAmHTU+wolfyioJD6Iuo+5kjxNk3EwIF/?=
 =?us-ascii?Q?KvbFSBih/NzxX/blX7kO31VQW8UAoxtqSIC/4heeZh74rNOXziePqVIFyI5T?=
 =?us-ascii?Q?Hg3f2LAngm32noDBAmrjRkVYAODlE2wpYEkD518uVOu6cAzNXBTN7DiMdUrm?=
 =?us-ascii?Q?OgsM8s3XBuM6mCpMIgsY76va+aai5NXYb69EDEQIiM0OPHw/QzyGMv5z7D3o?=
 =?us-ascii?Q?XFxOplcILPMNEE494o2zjHX2bR0eFsJV5G+/DDfb0lym8yH7yAzNGMUgKztQ?=
 =?us-ascii?Q?79MjOhLqdvQlYLprYQcWEq4M02ZQInVnMmRx4IUHR1N9+04Le/lyMnNctkUi?=
 =?us-ascii?Q?7S6dJG341uz27Gl6rElUnQKbhHf0wNWET0WDbebVjC2vuVaXY/e85gbA0k1B?=
 =?us-ascii?Q?qV0VjYgRTZogKaDnd+iLzcJZ0+m0Q3bFLUEBm0y/8+1Ifau/fXp1CVqNXGY5?=
 =?us-ascii?Q?1zMuk+kER0p7R7874D7TekkNJyc6sYxnnLblZ1ZnswoV8ROaxiTXLFZWvLRS?=
 =?us-ascii?Q?x9fc7/2NCM8hSoxkhQmKC3HpyIWj6PIW+agPsJ+mv64tncqhQY8Q906qVbGG?=
 =?us-ascii?Q?6KoFaw6H7TMmpZGoWE9QtlFWltgZ9X3yKqxRDuQDa26I+IQIuXNEW0SlBL3J?=
 =?us-ascii?Q?CA3dfpuoGFnzDOeLirCFo51mlM1sa7k9W/S+IRvtraBOpYIKRCyxv+bZaVnh?=
 =?us-ascii?Q?LO2w3lTg1H2yvHeBhEttc8iXY7hkhRif16yWbm/m5R+Og2EIuPKq2LjnZRaK?=
 =?us-ascii?Q?rRt93AARmdFX2OfsdjDLWRysaVzsXFrCDhNE+92B9cAp9mEbIg0AkJeKipmg?=
 =?us-ascii?Q?fPUe1uec4sOTlOq5G+F96k+4HFfgoQQBYNlvwFKAQ8k9gLoDB2sd/GOdoC5Z?=
 =?us-ascii?Q?WnlV/bMXVuLTM2P8xeZboRMfW3utL0Gk05Xt2woDbkUfE8fXv0Lw3Jb31Hrq?=
 =?us-ascii?Q?Ga7fL/ou9w8AjvXjrEw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca54f570-9b80-44be-d344-08db354e4248
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 20:50:43.8685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVXizY24FcS9CIQt9IlWlNwx/NuBFeJ/pK7pLncjQ/5IdIvTrzsLd4WVFpi9FooN7UkF1w1yA+ajTlsV3WMQpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4572
Subject: RE: [virtio-dev] [PATCH v14] virtio-net: support the virtqueue
 coalescing moderation



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, April 4, 2023 4:14 PM
>=20
> On Tue, Apr 04, 2023 at 03:39:21PM -0400, Parav Pandit wrote:
> >
> >
> > On 4/4/2023 1:44 PM, Michael S. Tsirkin wrote:
> > > On Tue, Apr 04, 2023 at 04:32:07PM +0000, Parav Pandit wrote:
> > > >
> > > > > From: Halil Pasic <pasic@linux.ibm.com>
> > > > > Sent: Tuesday, April 4, 2023 12:29 PM
> > > > >
> > > > > On Thu, 23 Mar 2023 23:24:22 +0800 Heng Qi
> > > > > <hengqi@linux.alibaba.com> wrote:
> > > > >
> > > > > > +struct virtio_net_ctrl_coal_vq {
> > > > > > +    le16 vqn;
> > > > > > +    le16 reserved;
> > > > > > +    struct virtio_net_ctrl_coal coal; };
> > > > > > +
> > > > > >   #define VIRTIO_NET_CTRL_NOTF_COAL 6
> > > > > >    #define VIRTIO_NET_CTRL_NOTF_COAL_TX_SET  0
> > > > > >    #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET 1
> > > > > > + #define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET 2 #define
> > > > > > + VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET 3
> > > > > >   \end{lstlisting}
> > > > > >
> > > > > >   Coalescing parameters:
> > > > > >   \begin{itemize}
> > > > > > +\item \field{vqn}: The virtqueue number of an enabled
> > > > > > +transmit or receive
> > > > > virtqueue.
> > > > >
> > > > > Just to be on the safe side: VIRTIO_F_NOTIF_CONFIG_DATA has been
> > > > > negotiated, and queue_select !=3D queue_notify_data, is vqn
> > > > > supposed to contain queue_notify_data or the number/index that
> > > > > is used for queue_select (I'm talking about the PCI transport cas=
e)?
> > > > Vqn has zero relation to notification config data feature and featu=
e bit.
> > > > It is the real vqn enabled via queue_select.
> > > >
> > > > Once the vqn is renamed to vq_notify_id, we won't have this confusi=
on
> anymore.
> > >
> > > vqn here is the index. queue_select is also the index.
> > >
> > Yes to both. No plan to rename them.
> >
> > > Inside notifications-le.c we have:
> > > le32 {
> > >          vqn : 16;
> > >          next_off : 15;
> > >          next_wrap : 1;
> > > };
> > >
> > > vqn here is queue_notify_data.
> > >
> > vqn in above unnamed structure is contain a. either vq index if
> > CONFIG_DATA is not negotiated or b. it contains queue_notifiy_data if
> > CONFIG_DATA is negotiated
> >
> > Therefore, instead of naming it as vqn, renaming it to vq_notify_id
> > crisply describe what it is for.
> >
> > And not some vqn n stands for notification, but "d" of data is dropped
> > somehow.
>=20
> vqnd then? for virt queue notification data?
>=20
"id" identifies the queue as opposed to "data" identifying a queue.

>=20
> > A notification identifier contains depending on negotiated feature bit.
>=20
> it's not necessarily an identifier. can be e.g. just 0 for all vqs.
> whatever the device needs.
For driver its just an id, content doesn't matter.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

