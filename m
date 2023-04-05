Return-Path: <virtio-dev-return-12017-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDCFC7619A
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:00:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 073B326A37
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:00:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F17409865DA
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:00:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E7C499865B0; Wed,  5 Apr 2023 13:00:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D4DC99865AA;
	Wed,  5 Apr 2023 13:00:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9gB3KJ8/B91+n9ri2NcXqJulaxTe8ZF2VMB+iPYBxJXBeLD49Uwv56Uhgm13XQk+XQShHlzij9ACSFwmLZrbnY9w4wJ/OK6LU2Ka2of2LpEs8SfnZfzRIxQPskQ9ssvbbr/CHZ4tpbtvokLWge4lROW7Qa1kMHmVRMIkKEFAB86iOlq0QTyGv30hS/md1gS6u4ZvdhM+aeMVhWCYkfxilWvjg19DXKDGMVQX2iCy2Ioxv5DcKb+bTD8ysuPauNMviKs5k4aaDxC4e7dLpQCysS7YzY4+cZ+d5YLKthuCI/U95I5x/w4T51uFIE3ar5SI0nvJOMii8OkFt8QH3XqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmpa2nYGRaCn8m0bMQhQNjx6EGJDbLhlt9UAmd2KVD0=;
 b=MZ0+AE5Ok6thvAWnd492CZeZVDS0QWdzw7CCHHTFebWUwMvaaEQ6ZFSpmM3oihvcQEBQ3L7xdCEkS6nvON2S2SKlGP/8pwB9aYMr8cO9VlfoeUoMGRCkqSwDZ53KCFAhQqPesHXeXXP2jRss3rcNk3i6wWQpQsWv1Qbf8viAdQ1A+f4Ua3N0vxn5IG2azibBac8io+wie01xQRSvlyE8l2ByTHOiaGbqSM6Czp1SBc2cuZ43J5R+YOD+87+QpULFoS8fKomEO3gBEYPUiVvUFvLKYcpotXPox6nT0kRd/76kq7dwcEDxIOgg7rpXLQhu7NlL5pViiyJTLCV8ttmrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com"
	<sgarzare@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v12 01/10] content: Add vq index text
Thread-Index: AQHZZ1r76yVHvMh3sUulmC5quinH068cL44AgAB+YUA=
Date: Wed, 5 Apr 2023 13:00:06 +0000
Message-ID:
 <PH0PR12MB5481C01CAA89EA6C9384F701DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405010657.612529-2-parav@nvidia.com>
 <20230405012352-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230405012352-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB7870:EE_
x-ms-office365-filtering-correlation-id: 24311ddb-d796-47dc-b87f-08db35d5ae2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IKtkZ/yA3vcrE9JxOsWM9LF/iqJxibq/q3m9lgXGMVwnLRqLuHYwrefYOvmWIGbPQm9AtJljQs+sVMhrgbutGcnDgfl+vE1G4upJYxwbIZ4xc3y7zf+Hn5WTj9trHE2sSsxwXzfRW0O8p5YnMobQoacbCRg6xOVA0UTrE1DLF6CPAm5FijSreCjYRV98TaU8fFlMbl8UWbJgISMItWewGp/XSLtqBM1jZs0hoKpMqc7zHjxUPUJo0yHKOT/GvReQ68wCWpqAFR6JYm54E8B6CYIkiSK4LKB9GfTzdcH0bfkbvuIJGpBtONGgSkqp7ubn+ZVnHOenH0jOvnA/swzInIC5oenmnW2fRZcclIepUSQD94es2v1T1J1jjlkvAZdvWNw4nUwFA/PDIzwVBbh9SLlOaBp37zXhu6/vm6cz9vnZQKLSPj/R39LpVKwGvec3f/kGiX8EuO29DuoUCN4ndtwPFVzumvDm30JQCwOv5fcYxigdDG2rp3pp/7CrLTLpnAgEgywogErA1iA9MOuErwJUyZHasipZKkc+GfwCg0Ph3wQirzhFnG4E5ahosrFyBu6fCkvmL3Ye1Z4onzHz6Kz/kQkvwCVh9X9Zm8dP5vj/JbcwOkLl22T9vBc5DPi/DZbbucrzkMwyqyHLuJ6sBHkLjdYfaSO4skOpz6D7XPs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(86362001)(107886003)(71200400001)(7696005)(966005)(83380400001)(55016003)(38100700002)(38070700005)(33656002)(122000001)(6506007)(9686003)(186003)(6916009)(64756008)(66946007)(66446008)(8676002)(66556008)(66476007)(2906002)(52536014)(316002)(4326008)(41300700001)(8936002)(5660300002)(54906003)(76116006)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TRRzq+7biUYmgrynDGB0DPA28wvSsx+W3yZHMAmDYbs1XjIpg6i0iaALdzHv?=
 =?us-ascii?Q?6uhG1MT/tKn0bKpBIkcpChBGYbN7ayhv/qh/NR415H8DJ88zy8AEHuz+rL+u?=
 =?us-ascii?Q?Su5pf2uwCEMm9Wz6UaOknzC7zNyVd+cCgzmdjRom57VQyAE0rF1cquDm8vZG?=
 =?us-ascii?Q?92jrfue16hO8NVaVZP+RRSgGIGZKpaG7/dCo/fQ38BliwBNuJO71gcBtDzvF?=
 =?us-ascii?Q?F9y3xHsRwvX+xRcm8xhgi5czQcwtg905mjUKt6D+fs0ic2YjMCty+ogciHyR?=
 =?us-ascii?Q?CdD2gmTX8Q91pI/1/bU6W/t9ViT/3cDV4iQ/PhxMIzWFs+V12gPK9OBqqHaJ?=
 =?us-ascii?Q?dfVZFA0M9Umk8ZvczVTxawr3xUu5LJIFOR/VjOk7Df3s4sjj8cD7VpkAfPee?=
 =?us-ascii?Q?k4NdEUn9frABKh0SQME9qiBK+KPcy1ibPJ3oZBsT4s1UQ7gkpQzUrFdEKP73?=
 =?us-ascii?Q?c/G3cqWkQjxcSbpWg4+k+50/7b/7hDbELB/+rmwhd6sN8Dwf6sAoeCVoYaym?=
 =?us-ascii?Q?qOy4FQMxM2lPNcCl0kwn0jQTVEYL/j43xVRutb6Ci+P3cN2BAarixrpDXT3p?=
 =?us-ascii?Q?pL9f8NRUkuWtdiYx8xgF3Uq+uozvxzoq21wKSKG9kKwDCrSI2iUSQgYo/zTy?=
 =?us-ascii?Q?TW/Jq0P9Kf5guQGTLnmaB034VHPfh0llkNKJUwdyl+ItgFMnHs/Sc/Jj7T3k?=
 =?us-ascii?Q?coUor5SyLI+Ka0FxpOxgLyYmm6oFutVQtArOgUaTtQ+2qioHv+4WkOXXYjSr?=
 =?us-ascii?Q?PrANaGS35NejNE7x9HTaTn3qvM74kdxgpnJWSaAcWT2eDq7WFguMcY/NeUxh?=
 =?us-ascii?Q?rO1X6sSDInbP94d4lYaCp+jJP/5pU0PItac5YCt0NU4G5SWZ4u5Dps+VYEHp?=
 =?us-ascii?Q?EbiKAgbkHZW/gGkz8BuIS8Hyb5Fskp2PRrf8zB3Mmp7eh0WHKeUsdmdv6Uao?=
 =?us-ascii?Q?qQ3EBwRmcH2BpPbIv/0Ieh8oRegHbCOkPid2Jb4JDKv4zjCUHi+zn1/b0n2e?=
 =?us-ascii?Q?obXJfXgif63ngmhIgXYK0V4KyeGqlb3BEdTfxsQMH9iz7GU5tPlzOidsZuaE?=
 =?us-ascii?Q?lSFwdjYYuwS2kx9GgdxIxGublLekkVi5Z995TfHgW5sUDXijmPIH+GcygAae?=
 =?us-ascii?Q?4D8nScDLpQ7NJh4VpaqR+Uqq3zTfzbHgvaKlj9ZPcyNL5GjFGIr1kijp3iQl?=
 =?us-ascii?Q?wzsyLHzYX89KE7s/RmTtxkj96yEPdAqaRk2a9WSBhnzBsSRAawRB7sT4uBYm?=
 =?us-ascii?Q?0gwnpBymgdF4kk3XRWq6yBaWqN93RDILP15RxGDX4k6vhk9I3U39lByF3n0Y?=
 =?us-ascii?Q?D/tMqfoDSxWJRHNkJQ9uIoI5D3K3m4d8VXuc65FJxCk4X2cjDyWm+JCNctJY?=
 =?us-ascii?Q?8YyeVaGQJWjybMZxe73zYne9expCPXsPgWrhI06Zom8QGnQlqCqPslltadRh?=
 =?us-ascii?Q?Is76e+p2BQuXa4GgH3wV1oMmSr8VQK+Enb0bvRAPwguDqoJp56yQLrcVMyYo?=
 =?us-ascii?Q?JcFxG9OGIl6dAnVZ04ydRUHn1OdBHhUKHB+F1NxVSNwz0LK2sBH0tVuXbU0U?=
 =?us-ascii?Q?BWwriz5IFEpqrCDzvCPy1ha15jz/3VdUcVXMOKokxE+NEuvd15dha+n22r/u?=
 =?us-ascii?Q?YMQdGjZ+KS1TOspgqjlRcfs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24311ddb-d796-47dc-b87f-08db35d5ae2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 13:00:06.8944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+lZLZ/6gEix7eZgaPrnEUfuG6+HiPzjHGI5D0jre/fZKgFRkkSs2fdj4R53MOV2B1bBaozCvtyk/Krct7XLGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870
Subject: [virtio-dev] RE: [PATCH v12 01/10] content: Add vq index text



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 5, 2023 1:26 AM
>=20
> On Wed, Apr 05, 2023 at 04:06:48AM +0300, Parav Pandit wrote:
> > Introduce vq index and its range so that subsequent patches can refer
> > to it.
> >
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> > changelog:
> > v11->v12:
> > - renamed 'number' to 'index'
> > v9->v10:
> > - added braces around vq number wording
> > - added vqn as another term for vq number
> > v8->v9:
> > - added inclusive when describing the vq number range
> > - skipped comment to put virtqueue number wording first because we
> >   prefer to use shorter vq number as much as possible
> > v5->v6:
> > - moved description close to introduction, it was in middle of
> >   queue data transfer description
> > v2->v3:
> > - new patch
> > ---
> >  content.tex | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/content.tex b/content.tex index cff548a..e64115c 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -298,6 +298,10 @@ \section{Virtqueues}\label{sec:Basic Facilities
> > of a Virtio Device / Virtqueues}  virtqueues\footnote{For example, the
> > simplest network device has one virtqueue for  transmit and one for rec=
eive.}.
> >
> > +Each virtqueue is identified by a vq index (also referred to as a
> > +virtqueue index); vq index range is from 0 to 65535 inclusive.
> > +
>=20
> It's the other way around: start with full name, then abbreviation.
> Each virtqueue is identified by virtqueue index (sometimes abbreviated to=
 vq
> index). A virtqueue index range ...
>
Ok. developers end up using "virtqueue index" because of addition to "somet=
imes".
But fine.. will change.
=20
> are there more abbreviations we want to mention here? vq_idx?
>=20
We don't have any user of vq_idx, so will drop for now.

>=20
> >  Driver makes requests available to device by adding  an available
> > buffer to the queue, i.e., adding a buffer  describing the request to
> > a virtqueue, and optionally triggering
> > --
> > 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

