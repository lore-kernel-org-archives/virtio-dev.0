Return-Path: <virtio-dev-return-11700-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F32C6FD20
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 02:38:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 969C460409
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 02:37:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F1CD98646A
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 02:37:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 83FC498643E; Wed, 22 Mar 2023 02:37:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D5A798643D;
	Wed, 22 Mar 2023 02:37:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I55xLKWZ3TG66q/Zl9w4oBSYXACqJSvnM27H/veSqATfFplMRyCiBSfTixvtuK4ziAwEbKlK5LKd7MSYja4x6GN9EChnU7uwibLVBJfibsqVXxDVm+52L3cSE/0ki/fHN2FoAR9mZqoOAeOQZ5QSDlVjXDh5Z3CW4U+Qh/5/EQ1q95p01cOpoV2uQ7VGwZRKUcFtFGEP9C7hPLbM+9EcecvIKcu8oMz69xYeCbE37dnyHYDSdo8j/6kJofvzkrcu/67qnuFipp3n4pR4zj+fkZo2UKhFSVLAxpKnYSKa+pv5jKH+6ZwC5XQddRyyxbTC53KZIjBMbW14R92P7hSxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVH3WX1rUnjNRg9SGHft7xJfljbpKEbj88G5i8sLUgo=;
 b=lGuvn6ycoz1PNAjfq2rnLJDc9U0wCyNzYR+R1Eht5YevE0lQQx1kXL2bwLnRq5uMpLOlqzu2MawOJZ476a0P6C9PysOijT4O3al4FgAhV72otWTL2nsP5wKUT3ZyidfxvK8NwjlDvcXu5S/JxKh2AZ2qI4Ou3KiK+vVgEutcPY4zuEqgs0FyDvlUY4JXEg+CbbZLtmLmnjLHuZSFyHu+WNK4Fy7Tk1r3N615oLMnWny3mlwN2rTZejq/t4Y3vaWMgJ1vC7kr02XOktG9i+gPZyWs8Dm1TE4QcaTwUybea3DFibWu7zN8lsVZY5WOGSeDeC2U/VoROpYqm4mvt40njg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v3 8/8] virtio-net: Describe RSS using receive queue
 handle
Thread-Index: AQHZXEBhAOCcFxUsWUm/MA+nPP3zI68FzRqAgABGj4A=
Date: Wed, 22 Mar 2023 02:37:48 +0000
Message-ID:
 <PH0PR12MB5481DD9C8A5D0B1B14A3B184DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230321215834.225856-1-parav@nvidia.com>
 <20230321215834.225856-9-parav@nvidia.com>
 <20230321180052-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230321180052-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5285:EE_
x-ms-office365-filtering-correlation-id: 065ce0ae-d441-4dfb-a1f0-08db2a7e6cfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 E6Wd2biBgI0Nh2SqbNtiQHoNuT5Qd2BvOVLXt2EaDjMboMz68da9avhi90GR5o3Jg1bCEBGvlSow2HaXEP22G26hFckv5NK3IO4Ql0BbOPKDnZyQPTBnSl/eNvEUD7bfQgI9nx5JEp7uy0MMlPKpv2zQpT0s2ak0+pDL522SdsueE3C7lZ+mSZiiL6zM6Ou4MoCGAsbBHO4szkx/sDnXIBeOI+4o/XH9sle1grpeCifYQBa91/XRoZetr2qhqSsIS2vDTskwwF9JMHJ4DT53q7f2S+nqyZlEfMgyKclaB01QsZPKbrVV0ySSMG0dyAeACQEzNFZU8j8w//jNmNgPzQEOeANbrOjfvcoaxcdcyGmZWJuYS4Kb3wFyD1jrqgoJMgL9umgzO2nBfrjMbHCWi/ByqY353Q8R3Mlpg90amFMXgn7Oub1eSYgI1JXXsQ8mNJEeGFs5EUE/eUUujWqSZ/gkKEGgqGwXXAAMmYwaRgpKBW39CrB7TLO4dqL8Jvo9ZgWp0myLPdR5mqxuyJmt6pwOMc/MkXtekfSCmaijvomVaADs/yqR4VhzHhS5oP1oBQMppe7BzH2WDNUt7RTTICDtx5tVGM7tnHjW36TPs+caFbypul99vUt89ltFFwXtrkOwzsRtbr0vmes1cyCqzKEuLJ8iZiurpK+AzRS2BqzAHDXku3LWW96kRFzauDcNi4B+RGD2ypJRHmjtYwFbRQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199018)(7696005)(54906003)(86362001)(38100700002)(38070700005)(55016003)(122000001)(71200400001)(66476007)(2906002)(64756008)(8676002)(4326008)(66556008)(66446008)(8936002)(6916009)(66946007)(52536014)(76116006)(41300700001)(5660300002)(9686003)(107886003)(6506007)(33656002)(26005)(478600001)(316002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ia3hNHgGQBLPa2/nbbVomgbY+uK19QxkjY0sM45f0nXT+6jS0knMjb1rzbaU?=
 =?us-ascii?Q?I4yvZFknJopvWnbTMDrhFq/T6t8TYueS0u5hBh6E5RehHJvDA86lu8Bp3rUh?=
 =?us-ascii?Q?tjWqqhpkgXrafkLLQ+Lqt8USPBHwY/s5Xf3oYpRmWNryMydkKrvv0VAjM4Ny?=
 =?us-ascii?Q?/MLWnDTq/8/h07FSc7wdERG0QN9eTq8qqrXYfoM9hLQsBD3Mf93AY7+nVjFX?=
 =?us-ascii?Q?hq+Srv4LOhyyerlJwKQqu+YUS4ZWPCbUGGUMta5BEOpY1EbzOdC5aMgLXUVO?=
 =?us-ascii?Q?FDUT2c+QMQQopWoapwO30lBcsa/OFdAapfzCAN5wNLDE0FLHjpW7muFaXu31?=
 =?us-ascii?Q?tlLnmdlUbJaiiqiAMWRwkYpcZTzRxhHobEkJDZy821FlfVXuj7G9J3PatJ0j?=
 =?us-ascii?Q?6yaPAQWCKjt7JNfxK3helIWkyLCrApNMFU/2qd4ZDwvKU8UPGtl6mltDRwVb?=
 =?us-ascii?Q?bUGpYtRzTHHcj4JX3WyPX9HV4yu1qmVKNSPCY+EgS0/5gT9PwuU4x4TLuL3F?=
 =?us-ascii?Q?gxKGIOPcpoc5BxKUZptjFqUHGWEDO6U4iexsB9npZjtBgk7JpvKBTrDUJNdA?=
 =?us-ascii?Q?9MhzAGccPq7QZ34xXR+BVMgu5tlsiDAthQF1yfmFEwxryDTyPqVMlupTJL4T?=
 =?us-ascii?Q?qgj3PRjlHV1KINyX5OEYoOc/LnMf0Kel3tXbCkW94V/73PbfXe6M5ah+C0ec?=
 =?us-ascii?Q?kx84jJKhm7cHM7lpeOXAVTsrqoqu0rj/OZGLdi7UlpLyFFxFSqsj7YU2zdkQ?=
 =?us-ascii?Q?RU9Z54zBBmPLpDfjtYQ1DDhNZpUF25wNMljBl8c+GLl6gEECFu0S/M29+TGg?=
 =?us-ascii?Q?Y+Lh4I6AAgB7gmisoSqI3FJmOUZz0kotDveu85j4oydfqfZQ/tFv3TzOeEx3?=
 =?us-ascii?Q?ph7rWXeWiYj45HNk97XgSOxcsRuXS/ptoCX8iOqm0vAVdjT4pBF2jKVPNbsB?=
 =?us-ascii?Q?z0Gmy465gmmTLMZPqZJl4GlnJW2upkEgMrZp26vrX9O2vDtvc2Ukm3cJ/oqf?=
 =?us-ascii?Q?bHyM3ffd88Ud63X05hnFq+iA3ycwI05lNOUrg+QNOSuInafa7g+ux6TlyA/e?=
 =?us-ascii?Q?0KX2kSZAi84HSl8xCJ6e+rgl5lcNoUg6Opi1tpysT6ODK6zIeMw9gt7xPNZR?=
 =?us-ascii?Q?GYjQaqg2TW7zyy2ILSFLh5lJz4xFnIjJux4aT0KX/SDqzqSs3b66hcAiMcqo?=
 =?us-ascii?Q?zhPktwcFAnwoDT2cZHV1psYrg1IZoOyj69GlGrjHBP6gywcdDv0U8jRzZSgu?=
 =?us-ascii?Q?97OXyExFn9oTs2hyc1EGb4RssC7pxjc/5QvuSXStD/TctpRtyv/j5I7XAeFF?=
 =?us-ascii?Q?40Oto6muyCn6grFUR881kGkaV4e1WlXa91rqHgFSPEsH3PNvAFkPWKru5+jD?=
 =?us-ascii?Q?DE1PzT5z1YQ062u4iY9ndCe2FlgLRz7UuJMSuHMQSEM4onJCeCEmtLiRmAJ9?=
 =?us-ascii?Q?va9MlrZilcJUcrC94h9pR0r4OYcY03KBjLmWcZpTn6gpy41wlnfK0rpEL/5f?=
 =?us-ascii?Q?Gw0zEjt1VLDV0F0fkA5IOBRnf6V6X0xX4XnClGXH0WRmhm25VgpUlzcqEIEw?=
 =?us-ascii?Q?hDRFRrG5YQa2BxsMut0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 065ce0ae-d441-4dfb-a1f0-08db2a7e6cfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 02:37:48.5617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMgotHScmkTV7AAZMt75o/n8u26rxoT/GXrigTAt6JfWs6uRq54lNEBKVq+UgZqnRNM3apagOKVrBIVuQ1QmTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5285
Subject: [virtio-dev] RE: [PATCH v3 8/8] virtio-net: Describe RSS using receive queue
 handle



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, March 21, 2023 6:17 PM

> > -Field \field{unclassified_queue} contains the 0-based index of -the
> > receive virtqueue to place unclassified packets in. Index 0 corresponds=
 to
> receiveq1.
> > +\begin{lstlisting}
> > +le16 rq_handle;
> > +\end{lstlisting}
> > +
> > +\field{rq_handle} is a receive virtqueue handle. It is calculated as
> > +virtqueue number divided by two. For example a receive virtqueue
> > +handle value of 3 corresponds to virtqueue number 6 maps to receiveq4.
> > +
> > +Field \field{unclassified_queue} contains the receive queue handle
> > +\field{rq_handle} described above.
>=20
> You dropped *which* queue this refers to.
>
Will add back.
=20
> And it's still kind of complex and non-standard. E.g. what does \begin{ls=
tlisting}
> le16 rq_handle;
> \end{lstlisting}
> mean exactly? Apparently nothing ...
>=20
Why nothing, it is referenced further down.
Did you suggest moving before using it?
It was just fine to provide forward reference.

> I feel what we keep there is really the virtqueue number itself.
> Just stored in this strage format.
>
> And all this talk about handles kind of seems to add yet another term to =
learn.
> Where in fact all it is, is just a different way to store vqn.
>=20
> So my idea was this: we say something like:
>=20
>=20
> \field{unclassified_queue} contains the virtqueue number of the receive q=
ueue
> to place unclassified packets in.
> \field{indirection_table} contains an array of virtqueue numbers of recei=
ve
> queues.
>
Above two lines are clearly confusing where virtqueue number describe in re=
st of the spec and above doesn't align to same notion.
So better to say field A contains the rq_handle and

struct rq_handle {
	le16 vqn_16_1: 15;
	le16 reserved : 1;
};

=20
> Both \field{unclassified_queue} and \field{indirection_table} use the fol=
lowing
> format for the virtqueue numbers:
> \begin{lstlisting}
> struct rss_virtqueue_number {
It is really not any superior in term of cost of learning.

> 	le16 vqn_16_1 : 15; /* Bits 16 to 1 of the virtqueue number */
> 	le16 reserved : 1; /* Set to 0 */
I like the structure and reserved bit that enables to claim one bit for som=
e unknown future use.
> }
> \end{lstlisting}
> for example, a value of 3 corresponds to virtqueue number 6 and maps to
> receiveq4.
>=20
>=20
>=20
> and then everywhere else we just say it keeps a vq number, we already
> explained it is using this format once no need to repeat that.
>
I just prefer to rename it to rq_handle ( or at least other than virtqueue =
number) to distinguish it from rest of the virtqueue number.
=20
> WDYT?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

