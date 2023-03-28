Return-Path: <virtio-dev-return-11819-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41160C76196
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 15:05:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5AC9041A36
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 15:05:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D38EA9864B0
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 15:05:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 316849863C2; Tue, 28 Mar 2023 15:05:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 173569863BF;
	Tue, 28 Mar 2023 15:04:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVah8t60YsNqy52OK4ghWj5iD6T4lCkDoVSyMxd0lEpImJHvzZwvb7mBQUvs9TCxn7gRO/4T7cDkK/2TR1dTNJBummdUug0xRgl680PfNF34spDd8ThhIXh6CkTreYztFXs03LywuDn4e3tkC4ACY5TixzWwxTchCR7XJWhdbQl03lpZecOxFnObaQdMHKJCu/DcxoZYCB+Ry2qRNpNq24b/PuMaKxx21kegvffKYDL9jkj9YzNfzmBZZvjwFPiy2CCawPOOWIveezI2mbVDgkv3fWDUSz76oEtps8GdWH8YSMnkMRY9buBZoAUcYFdLnWgT1P1G4j+Epsrrbh4IrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1oKA+KUp3RYEjCK5rVMDDqT7qJnfgV+fc0RNp+4L5M=;
 b=W5+nERBO2FrQmRMuSyt1OywvwnP88lBNAgqwQ3S+zrbRhexhCPiV/Xauqp41GbQUfVZOZOx35rlQ0F/tfGbOCyCXyEzWGfGDh2l8teZxpGByvG3lJ5opcjTzYDsmagmaW4/XGo3lD9suC9wBzKVJZORO50HIdqp4EZH8OpAH/y64qQC0d6wkpFzSK8+lpLJ62OgFHRF25Paw96iHQjRhWRfVz5GAZLCEjIt8oVbeROH2LgdMjg3GILQPlVsW3hlmv9jxyRWqO+aSf8FMSg28YnbWfXb1HC7msbOu5TOblQyvqFi7minb7ZztgcowcweMsqP/LlBkr+RQr5LI18PvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: David Edmondson <david.edmondson@oracle.com>, "mst@redhat.com"
	<mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "pasic@linux.ibm.com"
	<pasic@linux.ibm.com>, "cohuck@redhat.com" <cohuck@redhat.com>
CC: "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH v8 5/8] transport-ccw: Rename queue
 depth/size to other transports
Thread-Index: AQHZYQhBvT6BAHREJUyJENmtmnZCNK8QOyUAgAAO/2A=
Date: Tue, 28 Mar 2023 15:04:09 +0000
Message-ID:
 <PH0PR12MB5481B571104CA387FCB74EA7DC889@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230327235936.414196-1-parav@nvidia.com>
 <20230327235936.414196-6-parav@nvidia.com> <m2wn31as15.fsf@oracle.com>
In-Reply-To: <m2wn31as15.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB7927:EE_
x-ms-office365-filtering-correlation-id: 33437bc0-41a8-4035-9c83-08db2f9daf1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 O1K/w1mnSaEL4of2I+aSaNabSLOfqsi81Ym7Xb6uTxAPYy1RtnCyKvKi3vzSQjlnyzbrr2WnAoBH9gNYHN0PiF8EZcJvi0IPkq+wUsJLR6q4J4obK+zuQFpW172yawHx424Wnpjmmb82b3TqvU/t+cwgXLosa2AW34jEZjt5JmI1aKslAADTfPOXVVqcsRoEIsx+CS8VkoMiWUirjMZb624WNFGb/Ac73tZedEtBVTCYWPgbKliAAHuPWFdANOULuXTAuix+XShF0ksXeiiiRa12fRJq+74LXYoog9cQ+YsfZGq7EAo9SHO7/ijyLppzfAS2Rs0iCFUQh6tG8cHUEI+DIezy2zH8FN2DQPteb4Zk9U40qn7+7mlJqOOWJtAB07dU3CD3a1wc/KFjTRkD7eK63UotEjHegqozHmDGgJqJByE1h44iMiCiF2zPf2r2qEBQOwLJrJDug9cwC5M5tAsVlVCsn6Vip+UD05A6BKEJJQgc+rCxHBKLJ9yu99QGIdFLR5MhYozPO1uZUZwQweTIiJI+OkSa0R5OTgwB3etOW9KMTeXR1HGVJ4OhJ/gbBOlwCu7hFlFiNS6Rf+//03YCo7eAJW2z1nrSNRBFZrudZUrV7SW0KiQUeMKUdyZ2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(38100700002)(122000001)(55016003)(33656002)(86362001)(2906002)(38070700005)(186003)(9686003)(26005)(478600001)(6506007)(8936002)(5660300002)(7696005)(71200400001)(52536014)(41300700001)(4744005)(110136005)(107886003)(316002)(66446008)(66476007)(83380400001)(64756008)(8676002)(4326008)(66946007)(54906003)(66556008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z/poN3uzvjsme3EfkgJEEtYQ7a5On3KoY8LHNWhpG7VjBUnPOlglvwHpWO22?=
 =?us-ascii?Q?+rCBjidn7pjTmjugYClVJZJ146UQ8+0AsUYrO0NasaijD9BdzwxqIE2chHC+?=
 =?us-ascii?Q?cML7r7FBxI2z4OTbSJqreS4QjajSjaCzE009iQvKARCcMCG0lR7WlXhona04?=
 =?us-ascii?Q?tsh6NOybIMAeOCJ8ovodI2vDTSWJXA+fEpFTtJpmGMauCSRWLpOmtzQHKQoO?=
 =?us-ascii?Q?hs2kxplAQy4QXC6FTnp3gXedMjTvqRmzfZeAWBzcgLoo939PZGEEDTS6cpaj?=
 =?us-ascii?Q?h6ZfP0b8PMuyWdw72Ctkn94JG0TUJ/CySTWkAAns0b4R+AyvYmzyEYVzSgUi?=
 =?us-ascii?Q?kbCwfnXy2uHKk/7V3grzUtIVXhUZiqwaTFRFv0sqHrnTf1Q/llNFeyPMR/Yg?=
 =?us-ascii?Q?vJQnC/TronYqBQVJcmLvsMbdDR2ytYg/TgxXsXtzwcErpY0ggFTi1WA+tTAU?=
 =?us-ascii?Q?hmFouFAj7lDVgKLxVNvCTdQc4KQ9efJpxZweD64iKD4ndmBJectbUCWjAMib?=
 =?us-ascii?Q?by8axvqkvQi3mWz6r+7ysJb3o72dzniHJYu/TiqUBekXvj5dc4FEU0TXBNks?=
 =?us-ascii?Q?cT6AXrotRQ6Rxz6WoIfAcKQ/Cocak69pzDLuhiph9RrVOZb2I1iErJQ2Q/BX?=
 =?us-ascii?Q?edMs7AzbPsGZzp+9kUQWJK7LbbMB1fUUJtXiTMpHm47oiKt9lHiKz1434OxP?=
 =?us-ascii?Q?7ZHkw9IegMi1EVwgg5lkydHv4eSTqrLUA8C/UrxPh0a9HfrHN7N59kUpWYnh?=
 =?us-ascii?Q?bwx8tx+22P7Qe/F1bCs/NCjyVztO0zPlZdaGLyrP0CxMYZAeK/2ZSN+lX7ao?=
 =?us-ascii?Q?SfpLlfLwrLwzr06KYi3Lt3YFAMWnpS+dtNWR7rv+O3leHvSUa8dncn8z7BtF?=
 =?us-ascii?Q?6xlt8q0uI5JvpJN8+OpBzjR5bJd5rGH0xdIsSN7fbkcW1Zs2btmyrW2MVLmX?=
 =?us-ascii?Q?x1I9l0fYnFEXUqf79d9VNX8IHJ0OYSa5mZP/laG70BMNBQwTWhv9TQwa9F03?=
 =?us-ascii?Q?U1xWK9g6EbdNpt9SEuaMnY9aDIuQ9vwR6ga/7l/g3cMPo88pyYS03TsfdU6p?=
 =?us-ascii?Q?K84sfSAfsO6U4uoxEwXB3AqTdw0j57CbaxEt+OH0zBVRRyrW93t9F4jnQlaJ?=
 =?us-ascii?Q?Kns2P8GBj8yOdmk0+stKWNTIdIGqii3s00ogvsAoVbhu23dAnR+IiRUc/SR4?=
 =?us-ascii?Q?/wpcicEcXQYnOo87RQF5FftNymlpxBC8fiYkQ1B4FtewgvInBhLeU8fkA/d5?=
 =?us-ascii?Q?9ky6iTBNndIfMCWvEd6nCgd+syg6yJraoH1Rz1hXxtHYQVka/r1nhNI/ZkV7?=
 =?us-ascii?Q?cZCprMDrbG+m2GKUQyRPH5S1h0R3mWw5wRjCY7BG75SqC8EaS7qkqoif3wSb?=
 =?us-ascii?Q?3pLyB9yr5p5auNGRiH9hHban0qe07V7SD3lJaXjORlOX6uPUnJY0dzT9Ag5Z?=
 =?us-ascii?Q?/hPwOu/ZZIqWFSQV9SL7RtriqqrdzS9q4jljB3SNwRAN+y2UESshWWa7O3LH?=
 =?us-ascii?Q?rZpQjEwek9gUOQuOtZvPclF7isf66JGLQwWIAdHjlBMcx6uHc1YxWpG+5Mgq?=
 =?us-ascii?Q?7Wgal8nsUs4t6HaVyeo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33437bc0-41a8-4035-9c83-08db2f9daf1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 15:04:09.6944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ca3hgLDqhA+1ZJvM/l5940MyB9Ey+FfET3sIjLRSosJq8ofA9xNi81YUSqYiJML/st+qQj91KfX4Qu1TRm/qEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v8 5/8] transport-ccw: Rename queue
 depth/size to other transports



> From: David Edmondson <david.edmondson@oracle.com>
> Sent: Tuesday, March 28, 2023 10:07 AM
> > --- a/transport-ccw.tex
> > +++ b/transport-ccw.tex
> > @@ -237,12 +237,12 @@ \subsubsection{Configuring a
> > Virtqueue}\label{sec:Virtio Transport Options / Vir
> > \begin{lstlisting}  struct vq_config_block {
> >          be16 index;
> > -        be16 max_num;
> > +        be16 max_queue_size; /* Previously named as max_num */
>=20
> "named as" doesn't feel like typical language use - you can remove "as", =
though
> I'd be inclined to use some kind of decoration for the name:
>=20
> /* Previously named 'max_num'. */
>=20
> >  };
> >  \end{lstlisting}

I really don't see any value in putting this change log material in the spe=
c section,
But anyways, Michael finds its useful for some users,

So how about,=20

/* Previously known as max_num. */


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

