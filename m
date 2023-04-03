Return-Path: <virtio-dev-return-11938-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9149FC76188
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:29:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D840326A22
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:29:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CFF7498640A
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 22:29:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C694F9843C6; Mon,  3 Apr 2023 22:29:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B2C4E9863E4;
	Mon,  3 Apr 2023 22:29:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeqipibMVyp5Exh53NraeDUaPA/GOkJw1hYk7iBaNK2Bv7FGvzT1TowiTdKv4NPu2O4gL5OlBTlPAqRzcRATDlXCSLgJJrGoUPTZ070RJtBy3DKdBRv/nOV1fehx4EuNqH1n6g/YWjhKE/PEFA6EIHmLPZKyje6NshVbqSc+lDPaqwtIABHgkhIYUdd8s+xfZWvQvwnLHbOo45LQzFnLcEQDNYak/lpfx3xSiaQJyCgrFKEs+BKI6k2v7nEbSGc/Og9vxWfoY7zTJAwRQ4ZPMQOmQTkHwpf4whaSilP0lgtwdPNqTyylSnI2AntsYov3KMNIZHv8I+LgM5Kfj9ds7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDau5Ga6Ia5kkgCFf0ixQ2OTTWd3vr9LUJiwkmESzik=;
 b=FV7zMVhSx/SktsD0dtTqwSg05Hryo74w3tNCP/wgoCIKi7J/Xtoo+uTM8cJl+7ytovn3+JCbfgJDSM6b90DMiATauW/nShJgVXhPKbgkWBvw/zX8vK2P39Lba8pvnQtvPfZH7FDhRNXO1eLEagZkPE4Zdhz2ii5lF1MTf4JFTnokTEmPMvRL01xxB4EJ1rIgZW1pw0HRjGMD3Dfhzi1Nv9b4SmRHqkaGwTO02ERMhcgdjkkGSDY0cxhA7xRBiApJsQJMyvsytZCcfHBYVAsQRBg0jzSqSrSIgFhDUiHTtTgXiIv19Q/zjqnKg1BnGrQ1dYmxk16PbuJ+EqtilNl1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>
CC: "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v10 8/8] virtio-net: Describe RSS using rss rq id
Thread-Index: AQHZYoTN5bnvBuMC502wSQ6/nKf6wK8TC78AgAclg2A=
Date: Mon, 3 Apr 2023 22:29:03 +0000
Message-ID:
 <PH0PR12MB54816C0F0759AAD5E9C76604DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230329212341.465843-1-parav@nvidia.com>
 <20230329212341.465843-9-parav@nvidia.com> <87tty2fvjj.fsf@redhat.com>
In-Reply-To: <87tty2fvjj.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB6894:EE_
x-ms-office365-filtering-correlation-id: dce63d4a-a1f0-48f2-11f5-08db3492d48a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0Z8PryOPJgFW2JWvZboX3tEmmVkUbGNB3rfcLeqXGAJZusDPSCjF/WcdrDyW07TGppR68L9Js8odv/gD0GiPIetEi3Owbtlk2P1kCQ4by3CgrGM78NAAfx/2Qcfebmd+AtFjAimYYg/H53Dt3Ha1YmHYgrjNjrgUYjjb0vRP/JwKOqeFqiVYpniDRqn9UpmSlC2jwJGPMRP+ccLBSaBzarBrjHroSr1PYhG/EQqDMIGYTHfNr+dwi2jrzNflSvqMFx3oXFaiwHAXiouQfPtjYCOen6yMvA1mgzcSfiv5jc+Rz2jL5FKh/Hbf1crKUeALHrCY4Lffzac53n2JlXm4/xPxYje2A1tg0nyJk+hNajd1js/4b7PlZLqXSyvbk8UlXh2x95mHbGcTT7sLfZmXK8u8NgVzKS5EzcBIcPDJ8QfaTBIbKw3N6lgXfDESLt713nva6u1Vz8bGZy6Njn86delr0HuNdOOvjalhcceGJHJ/hKeFLTGyM9RXPCJDdvs65PZskKgIqZlrvIbQo1T3GeN2TtpDSjG7pCQi/whNzwam6DHwKQRG8PWOdQo+UEWfzzlioL99FxUOtZLA2iOWBMWnpCCYEiLmBkHOLzPJyeeVrOXy2w/XCTv73PScQ6qu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(55016003)(9686003)(186003)(26005)(107886003)(52536014)(83380400001)(6506007)(41300700001)(478600001)(8676002)(4326008)(66556008)(76116006)(54906003)(66946007)(110136005)(316002)(66476007)(71200400001)(66446008)(64756008)(7696005)(38100700002)(122000001)(33656002)(38070700005)(86362001)(8936002)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?op5ODnsBimD4LJvOdLq0IzUjBH7dhrlPgBcMs1qZFThsOQBEIHGWykLWx2Ue?=
 =?us-ascii?Q?ug3mTyJLenN9MofYIf7et+3VOOvvqV4IROJx5BdHDAa8r/Qa49h4UehJS2aZ?=
 =?us-ascii?Q?w4zcQkkDUUpkL95bq/FHx5HuRLOcqmzgp7Y3vWhU0+9yL1qMO0dZOtEgmFJ4?=
 =?us-ascii?Q?E176s3c5rvLD4sDhNlLaiJGa8A60soUZcMrIxKMPUSE0129eh6KbkAEhBqB2?=
 =?us-ascii?Q?TUKMOprurQR3gd8L8vgVKI+G8cVPis1A261iV0T6ksE1J56N5lYK1jXhRCyW?=
 =?us-ascii?Q?utuTWpkFVa+o508QVtS30NVANhgQhW3wN40iN/wM7A8qJVqI7Z1afMTrifAF?=
 =?us-ascii?Q?NGbXTi3ZnGEAd1AraQAZMfrocWgdj6g1DYGYM3AVui5BkrRokYZMnuqhCTYf?=
 =?us-ascii?Q?EfnDquJOjlVjwm5EFm0kC/sXyrrX+7PCg5p6bnWuphqffg9Lltguarnh3iaS?=
 =?us-ascii?Q?FNeDPqR2u0tD4XNQPSyc/7pXeLi23s3g2uqHyN0ityBQXl39SLynluzq04bF?=
 =?us-ascii?Q?euxfr/GIwzDM4LQDFwBGfmPtBabVBpTdCntGuUcmnwidW9gMXhnHQ+Smz1wy?=
 =?us-ascii?Q?4CagkWvR6nRZEJUCyOanqkxxzPrQfzTgC4ZQRCwzxfDPmRSWCGs00hW+IR1y?=
 =?us-ascii?Q?tjrUDjldhNNFwhF+tWVnLojGK5YnwF6H+9kEKGUsVfBuHqk/b1W8Ka7jubDq?=
 =?us-ascii?Q?RPUKArxT6qkc9AKKk7uwaLAnXYTrCtzpITyvGBG9oLyzf9rlVDznguxLhKFF?=
 =?us-ascii?Q?HtR7XP8GdPVp6nGa8I78mdJr1oXozAUqMGYGHzi5GeG8/2jmGSCSPWVXnyAS?=
 =?us-ascii?Q?R3O7G/KTlJFbxqkgI+GMVvSbUMcsLWP5EBOyIjhidXrQrxJIdcoLip/tFNuz?=
 =?us-ascii?Q?9pNx1NAcbjmtesEEmYCqZOFO8Eu5AI7D9XLg1oJTDyYSjTJ9NRnrkIpYTCqE?=
 =?us-ascii?Q?VLPH/NPYLPp4RxTIElWffplTxlleqZbFY5+wadgafl5gFpJSGMIgQ+rp3ifd?=
 =?us-ascii?Q?a7Nun/PK52mTq15sWfCF+5i8XueYFO1HWUKFTcw1hGhe+mdcrXACFhh0NVtx?=
 =?us-ascii?Q?HsgYJxHcYz9MFUqTwlJp4uvQUXPtJur8a9UzlZhWHJsPHXXz58Whf6QZm8nF?=
 =?us-ascii?Q?98//DkXFta0URTr1AwMfH50e4TlSV91omvME2zvjTdaixqHUb08m3iQKmA2X?=
 =?us-ascii?Q?KnmNAzmK9cOuVkR3ryK9MlIvp8WrKp85VeefVSTXGTqHRFxciK4UEon6AQ6U?=
 =?us-ascii?Q?XIYBYL43sgB/U8YHW3Jr2Fu9e9u1+UiswmmIu62bRyAg4EPfgnWr7QD2tknV?=
 =?us-ascii?Q?eH2pzqeXy/tYVmX7sK1wioS3OvLHdcaFlNeVT7jqc5G2ye5FzLDp4S8CjcbW?=
 =?us-ascii?Q?QEhCbwouTrY2HjZOiH5/kRRgZuz8cb3osrpm7h5n12EUMXk1MRRuYnOINmZz?=
 =?us-ascii?Q?ptK82HLVw4LgEzqXiqvKyIgahdDL6YclgsjWKIC9sJHLzl26EENb3/i86f1q?=
 =?us-ascii?Q?bLgxvelNigfs+uPDl/eaHAIfZf5ZiMQyEqiUHvkPqr4ykJV8AqX6Ks19pQhh?=
 =?us-ascii?Q?w/GQKLMxj1/KPXxBmi0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce63d4a-a1f0-48f2-11f5-08db3492d48a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 22:29:03.8357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 43w6LcD54wLOJIvwDiW2VMysxY0RLLk7NeoKyipPNtZvhGuoxTtNqaSxxOwWU3xp0G99/TK600KoZDeM22LNkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
Subject: [virtio-dev] RE: [PATCH v10 8/8] virtio-net: Describe RSS using rss rq id



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Thursday, March 30, 2023 5:17 AM
>=20
> On Thu, Mar 30 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> > The content of indirection table and unclassified_queue which are
> > based on math calculation historically. To better describe this, to
> > avoid intermixing array index with virtqueue index and to use
> > virtqueue number
> >
> > introduce a field rq_handle (receive queue handle) and refer them to
> > describe unclassified_queue and indirection_table fields.
>=20
> This description is a bit confusing (and you renamed rq_handle as well.) =
Does
>=20
> "The content of the indirection table and unclassified_queue were origina=
lly
> described based on mathematical operations. In order to make it easier to
> understand and to avoid intermixing the array index with the virtqueue
> number, introduce a structure rss_rq_id (RSS receive queue
> ID) and use it to describe the unclassified_queue and indirection_table f=
ields."
>=20
> capture the intent correctly?
>=20
Yep. Will use it.
I missed to update the commit log.
Will roll v11.

> >
> > As part of it, have the example that uses non zero virtqueue
>=20
> "have the example use a non-zero..." ?
:)
Ok.

> > -Field \field{unclassified_queue} contains the 0-based index of -the
> > receive virtqueue to place unclassified packets in. Index 0 corresponds=
 to
> receiveq1.
> > +\field{rss_rq_id} is a receive virtqueue id. \field{vqn_1_16}
> > +consists of bits 1 to 16 of a vq number. For example, a
> > +\field{vqn_1_16} value of 3 corresponds to vq number 6, which maps to
> > +receiveq4.
> > +
> > +Field \field{unclassified_queue} contains the receive virtqueue in
> > +which to place unclassified packets.
> >
> > -Field \field{indirection_table} contains an array of 0-based indices o=
f receive
> virtqueues. Index 0 corresponds to receiveq1.
> > +Field \field{indirection_table} is an array of receive virtqueues.
>=20
> "an array of receive virtqueues identified via their rss_rq_id" ?
No need to make it this verbose. It is evident from the definition itself.

>=20
> >
> >  A driver sets \field{max_tx_vq} to inform a device how many transmit
> virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
> >
> > @@ -1455,7 +1465,8 @@ \subsubsection{Control
> > Virtqueue}\label{sec:Device Types / Network Device / Devi
> >
> >  A driver MUST NOT send the VIRTIO_NET_CTRL_MQ_RSS_CONFIG command
> if the feature VIRTIO_NET_F_RSS has not been negotiated.
> >
> > -A driver MUST fill the \field{indirection_table} array only with indic=
es of
> enabled queues. Index 0 corresponds to receiveq1.
> > +A driver MUST fill the \field{indirection_table} array only with
> > +enabled receive virtqueues.
>=20
> "only with rss_rq_id references to enabled receive virtqueues" ?
>=20
In this field and other fields, we just refer to the receive virtqueues as =
rss_rq_id parent structure itself is describing what it is.
Hence, we omit re-iterating rss_rq_id at multiple places.

> >
> >  The number of entries in \field{indirection_table}
> (\field{indirection_table_mask} + 1) MUST be a power of two.
> >
> > @@ -1468,7 +1479,9 @@ \subsubsection{Control
> > Virtqueue}\label{sec:Device Types / Network Device / Devi
> > \begin{itemize}  \item Calculate the hash of the packet as defined in
> \ref{sec:Device Types / Network Device / Device Operation / Processing of
> Incoming Packets / Hash calculation for incoming packets}.
> >  \item If the device did not calculate the hash for the specific packet=
, the
> device directs the packet to the receiveq specified by \field{unclassifie=
d_queue}
> of virtio_net_rss_config structure.
> > -\item Apply \field{indirection_table_mask} to the calculated hash and =
use
> the result as the index in the indirection table to get 0-based number of
> destination receiveq.
> > +\item Apply \field{indirection_table_mask} to the calculated hash and
> > +use the result as the index in the indirection table to get the
> > +destination receive virtqueue.
>=20
> Ok, you remove the line here anyway, so please just ignore my suggestion =
for
> the previous patch.
>=20
Ok.
Will send v11 with updated commit log.

> >  \item If the destination receive queue is being reset (See \ref{sec:Ba=
sic
> Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the devic=
e MUST
> drop the packet.
> >  \end{itemize}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

