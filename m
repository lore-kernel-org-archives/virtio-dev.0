Return-Path: <virtio-dev-return-12530-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2E0C77B75
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 21:09:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D0F8A142D46
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 21:09:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C39929866DC
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 21:09:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B76DF9866B8; Wed,  3 May 2023 21:09:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A16A2986636;
	Wed,  3 May 2023 21:09:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oee9dTs0tsyeMbr/atkQ7Gr0FBWn811rj8Wfk8A+X5DoXj7Gs7iq43X0NQIwrVeIOXDl7NgEeYq5a6nGm1mmvsJGEuqR0rN3CCPjZyZ5EUJ8Ccl9uasd5ZJqqu+FpImGVCAUf6qxrporXmay28yI1BD69Z0zyYG4EB5azSDFGroV6WRzFS2memmOH5MxWQDK8wwna0zQbTFEqz4TwAIf2IO0qBq6E5yDVpOu6CCMRgV0onyXNOb3FMNNrM//q4C3tQAOmLn6b6yvZJKb4yyBHhY4M0s95CKc6lNZuuKamMTecXdVKbFSe5+zaHMUcjSswWKg15UiTGyAoRXjAH/jrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMDsWyjnKcJ1tDbpEKOlWWrrTZvbrEW9E3b9TjEtyZ0=;
 b=oabFeYphYyY0qAFC3w8xu9vAwdViHxDipTQWI6xr5IQUJ8YqSOKBHUqQLN/VwuhJ0jbUBS8zP94LfeyLBg6JTpGt5c+tDVDziTjXJkysZsH3Foip9XBs+r2FzK2yAmLuf6/m6g2OSlU1LExf+iMDx6yONkLH3nXqCvOrRYvqMwfehuEzcrYOp0WTjhE9I9KkPsEve44XxRPL+Ok90RU4GiH37ZnL3vJkOp4Pi3/DBgVbTS52ov7y8L1iwVYtel4tWIFGeiTH/W2V88vBPMRzw9DpVUmFhlLvegm8B4juP7gks/rvAIKHB0BBkV9udPSCgC5uQ6toWFMuwli1N2cpiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: David Edmondson <david.edmondson@oracle.com>, "mst@redhat.com"
	<mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>
CC: "sgarzare@redhat.com" <sgarzare@redhat.com>, "pasic@linux.ibm.com"
	<pasic@linux.ibm.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-dev] [PATCH v15 01/11] content: Add vq index text
Thread-Index: AQHZeYi8PVn2jpQMM0CA3TNaBeMhM69IYq4AgACvdSA=
Date: Wed, 3 May 2023 21:09:29 +0000
Message-ID:
 <PH0PR12MB548187CC08E9DA78AEB3A9E1DC6C9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230428041949.411221-1-parav@nvidia.com>
 <20230428041949.411221-2-parav@nvidia.com> <m2lei5vh2z.fsf@oracle.com>
In-Reply-To: <m2lei5vh2z.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BY5PR12MB4952:EE_
x-ms-office365-filtering-correlation-id: eae8d156-d207-46b6-4faa-08db4c1aaf7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XyzV6c1dA7kwLolfKPX5zhNukusxJW2PiyrOkomW8V2Z9B/jp80yNNXyHYFTDs6irxa+PEgPTnwhsrKCbgOVE1FHZSq3EpUv+rgKW/5vqtLTSw8Gbh7v+Nz0sKaINtjaBQ+y8Zrg0w933J2nfV436K1TI2w7BG7xeoJUCbi/FheMRK6FiZOWyxIlPrMRhkwLYvYu/s81iFYg1LrgH1mXqYGBUb/lUk9SKksH808/APlb/Rp8A8EyKKClO+EnrvekP3vqfrYaKHjallDWXPE/aUNq8p3PotpTw/0KPUI84ORIflPqgJgOUuYuNe7wY39jggRhszqoUNw+Gz7fvXe1Bjb5z3mlk6uNFpYH2RM1rHJGxeSEIApRm5JL/zd/A+8zoDrVqNKVt+zyg19VmS1w1lFrGMOidx81JEy1ZcianxvNEP1cYNFw+oLRGx1dQDpSgpGFS7TtqhRbmiHlp9ZWjF8Se9TVf9Wzgom8Xui3PLWh1o6WkORNUW4zCgNBAGkIFglx4B/rjjbUpHlWXGb/p0OVoR92Qkc0oo4F/AUPPwlSaCCTGeKpaWhvAC4q7ZSw6kQDfeqqkzV6vpyBvYCETJ2m5wCJm//RGcYYp+LiyFCpzv2KugF1Q0kR0JGO5nYp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(33656002)(86362001)(71200400001)(54906003)(316002)(110136005)(4326008)(66946007)(66446008)(66476007)(7696005)(76116006)(66556008)(64756008)(478600001)(41300700001)(2906002)(55016003)(5660300002)(52536014)(8936002)(8676002)(4744005)(38070700005)(38100700002)(122000001)(186003)(107886003)(9686003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Bum1quMuscFeUqveuBAwgoS/hGC7XO/rxKylw+DLIvEJcSsbsFxXPYbH6bvM?=
 =?us-ascii?Q?Y+7ogssviMqid/dUI0gYgjEZkjXW77ySwCaQetiO3pFhwtYdQLzte/MRBVek?=
 =?us-ascii?Q?dijBHHgl//UaJepBWigi4O1/r6/uwjqdNUKlNpayEJcyvS/mYPYhzrwckKBS?=
 =?us-ascii?Q?S7eBjnv+X8UUyfMki5ygzc7VKfvR+OY4vthJ7LBFvgx0dBbWV1zJccK+/xy8?=
 =?us-ascii?Q?DR9e8HxEIGEeUC+ovs31k8pnFn2bjpnlnjdP0K2rUGHw7peLF7XpNqCKMNtA?=
 =?us-ascii?Q?l8gOuuTFvH7RQ8AP0+dJeo591llpW3DC4vz5F3VvVXP51ysXwvsFxLVlC6tL?=
 =?us-ascii?Q?7NpxzXD/s4mTliSUBnCT4xAa/YT/UaC1I7whtc5phgUQNjQrgch5NZXHpPSF?=
 =?us-ascii?Q?UtHg6fiLmjdfFFUXK+LUm2nf6YwhUp2Iu6ovT6wEOXLDAx47vWXCylW/dIUS?=
 =?us-ascii?Q?wVrE+ywHopfxJe5bkBZd+FHjvmgDBLGg5Eyjhpo418+VVKGChj9s6xXoLzgF?=
 =?us-ascii?Q?m8kQF5/p9hbj88b1TCMouuHaaqx4+PXFsSiCy9nX57QU302SYzAiT9aL+4gc?=
 =?us-ascii?Q?bkILyNf/h50oazqSiM5kiXmaBYTZVbghTznx3qXWZkoOKMXdBKPDvLhuujzi?=
 =?us-ascii?Q?K0lJfmUPnme7uoXrr3nJB17hhx2W+UfJ8pTAqyYTRbl3SH3xBNYblWWYSaRo?=
 =?us-ascii?Q?M0zpbQtiSLzlip6lwu2hE8pYyp8HyiDDhJphthGApw+hVc5msJr9WiZacMxz?=
 =?us-ascii?Q?DzcbccQvRf60RbmCpg5y1/kTed2bcegnb5aIta/RhGJkrf8CgI+zVtQYn0ZL?=
 =?us-ascii?Q?NHgTpkdN5mQMel4g/jJUFrptlf4geR0HWBGwGoG87s3E0v1YKTiAyZVJiGl4?=
 =?us-ascii?Q?SLn7mqgVJjA59ZHxyJaA1UnFKTyK7BFZoGXmf2ntbrrlavjoZP8n0drS/DVQ?=
 =?us-ascii?Q?RmwEaV/v2cPim2/VtRqLz2pnyQ9z3hUoXw7bc/RCFoqLgIid2OldyrjlstHv?=
 =?us-ascii?Q?WXK7FIT3NByudVktsPzMGie957MyiEhEFNHK4P/3C9zA0GCNCz7PanJzK1u8?=
 =?us-ascii?Q?DoAY/lLR7EKub5cZDDuRfpw2hbdUgBxqyC6e4365J7Bu8Fz2hj+xsJfnhuXT?=
 =?us-ascii?Q?eFsMl3Eemq686SVnOEcH7t/cvaZp5s3EQ9jns4c6dJha4I7xjLBaE59dqEOp?=
 =?us-ascii?Q?dgEEd0f3Kh/V6xe4Fvn9k3j9VBixG6iEWAJoKYrqmjh0OvqRTn3sI3kMnMRN?=
 =?us-ascii?Q?j0D558SGxBCScxu3KL2f9Rc+6RF8WYkxp/uJrRRTOFntdL6e8stmuxbo8pay?=
 =?us-ascii?Q?h6JsjynOFzNEWhw1M1fnn5apz01HPR5dwyYu0T8zVHEvcuTWC4i7/QRTtfUo?=
 =?us-ascii?Q?ETPMx393F4OUti6xJCPVQ2140frUDzmCcsFcAXedkppoSH1hZwpm66hiYBBn?=
 =?us-ascii?Q?MGVSp0IcnGQSlcMeZswfAYJKYMQ6uAMfBqEBS1TJu8U6O8sRUqTkipr58+3e?=
 =?us-ascii?Q?orGFQ7elXVx1kvcKA6mqjI+Y5lfgQcyvh6KkmkrtwLoCIh/k8ZRmeWMyLtvw?=
 =?us-ascii?Q?Kkkb3efi0NXBxoPD+Gg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae8d156-d207-46b6-4faa-08db4c1aaf7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 21:09:29.9977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Os6ZLzkBs8OMLtkEOkwvNZ9eaG3vajEhTbTM9IZqU+SBPZhmNE3dAAu9IKINUkICfiQGZBBwLQ7qgRwtFLY29A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4952
Subject: RE: [virtio-dev] [PATCH v15 01/11] content: Add vq index text


> From: David Edmondson <david.edmondson@oracle.com>
> Sent: Wednesday, May 3, 2023 6:35 AM

> >
> > +Each virtqueue is identified by a virtqueue index; virtqueue index
> > +range is from 0 to 65535 inclusive.
> > +
>=20
> The range is a property of the index, so generally we would say "a virtqu=
eue
> index's range", but that feels a bit odd.
>=20
The range applies to the virtqueue too. Index is only to identify it.

So how about below,
A device can have maximum of 65536 virtqueues. Each virtqueue is identified=
 by a virtqueue index.
A virtqueue index can have a value in range of 0 to 65535.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

