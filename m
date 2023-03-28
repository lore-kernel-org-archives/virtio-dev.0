Return-Path: <virtio-dev-return-11812-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DDFC77B62
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 14:00:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 12BF9190906
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 14:00:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 04BC79863E4
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 14:00:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EEB3F98637D; Tue, 28 Mar 2023 14:00:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DDFFD98638E;
	Tue, 28 Mar 2023 14:00:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GewMkm7vV9DRU85kV7uyObuLjWPWt9+pJFD2e2sl7fUaj1UeVT+SiRXnkCCO4ltzI6ARW6j44hWavcYNBClf7N0kjPYU+ud5/qjorQ/vpf5ORBV4Dx8vEGlVvJ6saf+7FLz7XznnoJ87pNHyEs5Fk+y7nDaNqjrku2QKcB+PwH0w/H97qWva8wQVsWdhfDVhidD/aoK8hdcEvhSwKduMPu9nrrJ/BcZ/drrby8luQpLvagFv3bylnueTGirosx3RFrZo630keZ9OVlevwWUQAn/1CiHs34j2UStrU9dT3tH8K4DVQ+Vj4Tdzt/AkNx39uHt4gcqfOLXVDxKyhIXkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKJbjDIFFmGYgE2MEoO7BJijndL85+VQQ5lpoGvghFU=;
 b=jfm7I6p4iLHZHoiC3F0KvuSnth69NagVGb0/COOX8yEMVLS6YwLlBos5Y3ltPjh8on7reuZgKptbqzpILgAPkrjPaoasUCrxKwzW9+/e4jDmTdtyHP2jSXTe4ilziennTnXOD/+lNWNFleW8FG5Ku/lIwIdxGx/OXBNkWjrh4RjOuKZ6509gcHNlJjyMR9bctAUjWpkViQUWykk8U/vYyH3sDMkIIfVzIQi9kpIm5C6bDngv78SrI8YVAHTfd16fIafYQKHgZeztZeuuFBVX8nKyrKSbGzsuCAfSWm0WxU9Nk4m8pI+csfPraT+V5//QQnWH1T9AqJxdQO80OxOMsg==
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
Thread-Topic: [virtio-comment] Re: [virtio-dev] [PATCH v8 1/8] content: Add vq
 number text
Thread-Index: AQHZYQg+dUPpBPQQuUeFxwscQI5HEK8QODWAgAAAnRA=
Date: Tue, 28 Mar 2023 14:00:08 +0000
Message-ID:
 <PH0PR12MB54818C63DA9F19F9EC501E16DC889@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230327235936.414196-1-parav@nvidia.com>
 <20230327235936.414196-2-parav@nvidia.com> <m2bkkdc734.fsf@oracle.com>
In-Reply-To: <m2bkkdc734.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CO6PR12MB5491:EE_
x-ms-office365-filtering-correlation-id: 99d38bfc-462d-4cbd-70b0-08db2f94bd66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XonFtQerWnOAwGZD2tZqkZ/4rt5yxkahPobma6Em/GOqSRv1qMfFIx63E/x81p6myHOIk2V6GLe5uCdzPDW4/PEUmSlAWqvtR3Dsu1vkhZLKYMTm5vsBy6eblzvjb7y6nHtnv/H6THfpEg8zkcPzzdGfpd93lMASJv8PYxsz0rU+EXt8NQ8V9fAB/I6KZ4Nt6tge4OUtCIHXg/TekC/cEVdxjO5eA12yx4PxGWwNB9be2DtjDPPfQJmfkri43BFZeXANLbhIks7zYq6J3AkF8Nxqbqm4DZlMvZ3p2P0lmfpxSm/EFawjDqWmsdcpISOAqaeJfaJU7liv3PLvPqoD24aCv/j5r4vtb6LgKaF6D4ysrlIGNS2h38DY8U0jUfXIEvgaTDpQyyNxODXQUCyn8kA1iDbfUmU/rEc3BuQjSzyPA9ILwNVGnliHEQcvCvMWmkEsTnvUJX6apoc7sZR2yK1AkRcygNTuWEMaqThGmfPGx+xN6vOe2CG/UwsmbzpEMv6x6vtgv1ncEZUH14qO7E37A3Y7KaPAcH2rQO5AzrAu2fz7IIZLTQH/J0vbvan8B/k7NoiVnYWoSp9RyTbfgzFz1QBlXWGbEtCa1VusITMPBZ6Ja9TfLFWosF54xxxiQFu9/2FI8JJ8tAuLKIQTZwyh/YFPYDfdGXQCj7XKMpsH6CIZiwHI7tXFbuojVQm3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199021)(966005)(71200400001)(7696005)(107886003)(478600001)(110136005)(54906003)(6506007)(9686003)(4326008)(5660300002)(186003)(41300700001)(52536014)(8936002)(83380400001)(66899021)(2906002)(316002)(26005)(38100700002)(122000001)(38070700005)(76116006)(64756008)(66476007)(8676002)(66556008)(66446008)(33656002)(66946007)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PAkgWcPfshk+AfDgRyUjyMUwE/NSRpBRTw3Pq94VWI0mK8XprmwVCuTKbwTU?=
 =?us-ascii?Q?KgjBoVKx/o+dq3qPcoI+heWy0WpT1Jm2vpdBDHeqjIWqhOIs684Ii00tyai5?=
 =?us-ascii?Q?8kinhzvbOXrm3JSZKxMkIJfSOKuG1ijLw42zJGUpKAANrBAiv0c7LNOTn5S1?=
 =?us-ascii?Q?jggNrBHY47ucqg04W2c7ZoCRgIDKav0VCtIqigaLCXrmvC89MlSfGW03+Fh1?=
 =?us-ascii?Q?zGVJ4wkgr1KZiC2TM2Q6cQp9oD9bSs/AYo1ANT4qW2g+PGVtwj+QOMyXx1ug?=
 =?us-ascii?Q?U65bpYiFaPL2zsS09xynoYGYvaLwinN5xfeci4dkMuQnIsk7JXZwPg9Rpe9e?=
 =?us-ascii?Q?CPuQ2XdE2iNXnPnar2CfOuJW+R0WAIWUAIJ9rfR6Swa0i6FEESBHbYKUS1do?=
 =?us-ascii?Q?D/Lb3mEaE0st8pSPjh6YUrdc+qWVUmcnP1CV2nxSGGA0uJEPSpw3Rsw4Fjx1?=
 =?us-ascii?Q?lOCfAKEpuGcvrOH1e1r6MIuhKRn1Yvg4cBXuvIVdX9Q60C4wxQ2ychYz0Kpg?=
 =?us-ascii?Q?QbQDfqucfB2RUm0ZbjrtLsCYqNCTN9NNIwO4RqJQAxvuoV4Ge/gc+FCDJ+02?=
 =?us-ascii?Q?hax0hcZsdWOYh6GwCpBn9kg/GsXCRckag4X0D81CtdRjsdCIWyPuViNPypP7?=
 =?us-ascii?Q?cUBbXFzex8VkFzN5GV225+7GdmkbQLhPXaA13Z0CE30hGrhjYWtay9lMAovu?=
 =?us-ascii?Q?b9nQaEBxxGZE/qMScoluCPaNX/Qx5a2kFCkLeiW0o/XK0vZbaaO0txTMqtEV?=
 =?us-ascii?Q?MrtcKURSg+2QGjUVaCLalIdc0MQpL4How1ziRAT1/29zQ3hILyM8fHQGpSpk?=
 =?us-ascii?Q?Rs2Os0kFgM9eWnpTW9/A2NlhZ4enTUf9jDmHuwch5mnuu3jncJVKfqV1Rlaf?=
 =?us-ascii?Q?tTbVbVqt7atNTcDNJYU/yIWSo90SqKBIFwptKjLmeYfHFfcxHN3AG1X8XRQ3?=
 =?us-ascii?Q?CUNGW1uj8mcDQCDj+6MTST1bGCW3EtO6rf0cZKIXg7f1lPxzm3/EqlHOeUrr?=
 =?us-ascii?Q?1U9sieNClIuUaKeySruXU72oXAlJmaBsDEQu2e3y43DpFPZGk5tC+FsS7g0J?=
 =?us-ascii?Q?RckqGRmE39OZmPwDESRPPwcHJ/39+i7GkDia3z4v2slXg1Abgbqv5+uPK/DT?=
 =?us-ascii?Q?03Fw58aUCLOC6/UIH/jyqAGjpzldRSRn9Kg8IZ9e+DkcZ5MFRGisJft6q4fe?=
 =?us-ascii?Q?JJ+75yQeFtBycSE+I+xsg3SAtY4gO+y/NSSyz7I2aFClnnJ3ER43OSk2hk7S?=
 =?us-ascii?Q?jSzBeWbrcgnAga2yknMzQ+guw3shWjrbkNMH3mCXcJcTIrXhGIjVx1UtGET/?=
 =?us-ascii?Q?rB8cx98Ko2J4AuhVDEbHxPI02vXQLX4NAMdVThiLP6lL1AHQXzxGjSsnxHlW?=
 =?us-ascii?Q?ll7y9O6R6tVAShjr+odYQc9KE+gBcySf7K6T7vEbALaa1GF/Wao2qfRqqBfi?=
 =?us-ascii?Q?pmz4QpZcsIixJOg4aw4gmcuM9c1tpnh4iD/7USsPyZjEvi9bFyvWolri/GML?=
 =?us-ascii?Q?gSbDTNL+vvpCXUjmVU73cJy+6MRegFfeJ5aZRDwuUsBc4HF4JxkUNSdSt86n?=
 =?us-ascii?Q?weXZs418Q3FmnNEdemw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d38bfc-462d-4cbd-70b0-08db2f94bd66
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 14:00:08.2235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 977SMDqgimTeEnCYbNDj0RenA4yywUSp2RLbdZpm4KBMYnA4Hhr+4WeTU8moBi4TIQyLnyi1xbdzsiJtXFWHxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5491
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] [PATCH v8 1/8] content: Add vq
 number text



> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of David Edmondson
>=20
> Parav Pandit <parav@nvidia.com> writes:
>=20
> > Introduce vq number and its range so that subsequent patches can refer
> > to it.
> >
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> > changelog:
> > v5->v6:
> > - moved description close to introduction, it was in middle of
> >   queue data transfer description
> > v2->v3:
> > - new patch
> > ---
> >  content.tex | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/content.tex b/content.tex index cff548a..5171c12 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -298,6 +298,9 @@ \section{Virtqueues}\label{sec:Basic Facilities of
> > a Virtio Device / Virtqueues}  virtqueues\footnote{For example, the
> > simplest network device has one virtqueue for  transmit and one for rec=
eive.}.
> >
> > +Each virtqueue is identified by a vq number or also referred to as a
> > +virtqueue number; vq number range is from 0 to 65535.
> > +
>=20
> It would be nice to use the unabbreviated version first, and we could als=
o
> include "vqn", as it's in use during discussions:
>=20
I prefer vq number first, as reader can pick that first when using somewher=
e else.

>   Each virtqueue is identified by a virtqueue number, also referred to
>   as a vq number or vqn. The range of virtqueue numbers is 0 to 65535
>   inclusive.
"inclusive" is important to add.
Will add to v9.

>=20
> >  Driver makes requests available to device by adding  an available
> > buffer to the queue, i.e., adding a buffer  describing the request to
> > a virtqueue, and optionally triggering
> > --
> > 2.26.2
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> --
> The sound of a barking dog on a loop, a plane rises in the crystal blue.
>=20
> This publicly archived list offers a means to provide input to the OASIS =
Virtual
> I/O Device (VIRTIO) TC.
>=20
> In order to verify user consent to the Feedback License terms and to mini=
mize
> spam in the list archive, subscription is required before posting.
>=20
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

