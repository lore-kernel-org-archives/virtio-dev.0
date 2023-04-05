Return-Path: <virtio-dev-return-12023-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823C3C76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:20:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D216529FFD
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:20:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CAEE79865B8
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:20:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BC7C99865A7; Wed,  5 Apr 2023 13:20:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A1F499865A8;
	Wed,  5 Apr 2023 13:20:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sw9veVg3MRcZgXkaxVtbXh4aOS6hdC04OZf0Je46yf9R+m3/d3cb71VJTvTuyMyoYN1fL3AZMBOhjlE6fMqSg+ecYzBmL3HZ4fkNcwr7pilKDSoHBw9Myq7zS3c7Q4TrsaTr45vMEglmOcffRTMr9CLbhJEfykvfSBmx5rW5KafSm7FPyeUOXqBVfnnPFyv3CEcTVWSkF2dJZfSt+XI3doxLtsOic/TDCC+1Aiju4NZG3WHQQeKK0SPwl5MIx/9ENXN+Aud2GA7n7PHglITtN/77cdM3ok6873KTX6APo9lBsn4KcivupYljKF4w33BrrAE6uL4kPDkefSHVEGCeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdJ/H7V1Kl4LLJjqtuSHQHnKtC+84aC/2Rqc8V/GHfI=;
 b=bwXXHzX6pyLMSIZjC5CLNdp30YrZPFXpUdoHSPv7t3xoeRCRXLC98f1iHPjmaxkuyxVh7LQdSqvL6dF0lLgisRCa7KFr1ZQlxACIGCRchY/ocojJ5K6FBQ17SQFKKMkleRoTuGwSArjX5/mokfFi3qv2fdyy3sFb5j2c2UEzHlaF1pZhw+Sd0n0NSvHhVM9E4YIXVRgGbQVrg6AMtWlb5jtY6S/grBYMqNHjE2SZLwHn7qM8qTIVS1qO3HUalBAtp+d4o25PZNpjdz3EaeOYcGtkqNvUqHfMgFmZUi4KxB028fpw2RWhy9edeXG4mhqfiUPqpej/Kef5iXV+wMVq8Q==
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
Thread-Topic: [PATCH v12 03/10] content: Rename confusing queue_notify_data
 and vqn names
Thread-Index: AQHZZ1r8zVHaZ0BrZEO8XVrJh+aoSq8cLmIAgACE3vA=
Date: Wed, 5 Apr 2023 13:20:04 +0000
Message-ID:
 <PH0PR12MB5481ACE86E296DF21D942C1DDC909@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405010657.612529-4-parav@nvidia.com>
 <20230405011326-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230405011326-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB5517:EE_
x-ms-office365-filtering-correlation-id: bb7e15be-b086-40e8-46f1-08db35d877c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AsRcCcm03c10NiL50swtEbDHyqeTe1V8FqBiyjdPNbvjJ33ltIimrtzW0iq59lgNym/E28xkQTrV43KgppUowMXcUtere7LMueEEo0fxRnEzjDVprywYZCqpgsXscw84vhZ3BZQA2unUFx9JI+8ipbHkN/rFNCFjMLQOOAtTxL74TiJYWTVuDUpyiNe/lG8nSiu6It4dfRQsZUz5rDoggDx55CCTkdMuzQ622a7B0GPGV2P5MVnZU0cYOVpLHyV72+YzdJbu8eg6W8HMBvTP5duUC1McGpRYJsZ8Mh4+BWW6qdy9KAEQVacOgJpZdnbpEBtTdjgUAgNI4myYxiCx3gTEkdo63SpuLk8FBEocmdl+dVWKiBUpueZkXu+nK2mBe9WobLIM/BPlwDNaQlREpALEIc7AaLBHgMeT1uEcuI7sAsdgiIi8ApAww0NI2eWnN5wqV9GYw/V3XtssG542oFnMwa/vDFTNzeSJs+TGUg8R+pjgyYxqFEF/OGYkK+DQcMZArq/9tD304j8wOUEgkdIiJdmDm87R/4PAtp7eMlOlUrrtbPI8uSsRIo62wwA9oAqc76QegLa1SD2gL+fEYfyFnsDyOANRmiaB/QXuZjIrFAZLjt+ZerYDIKAVx/HF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(107886003)(41300700001)(122000001)(7696005)(86362001)(38070700005)(186003)(54906003)(6916009)(4326008)(8676002)(71200400001)(478600001)(2906002)(38100700002)(76116006)(66476007)(66946007)(66556008)(64756008)(66446008)(83380400001)(316002)(8936002)(52536014)(5660300002)(9686003)(6506007)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XVCewOim//g9Ww+WokpwzibvB7H5O+V+0yVgxCbzg8nVoUQ9mvRs47Yo7WKK?=
 =?us-ascii?Q?Fe+X9Ka/mzHX7CIYTRyDi+aJeDOvNXVZoPVeRYvzHU0a6JrawUVGXaoQaANi?=
 =?us-ascii?Q?QS/9YF6GOKilxB6IH3kuEkj4bUITABUBTu9e+2Zg9oaG3NVMZRMtCx6Y83sM?=
 =?us-ascii?Q?8//cc1PYsIl1qAeiR2iYtN3mxRGFEkEvxYCAFPfV2PZJDYH1RJK2FyEGBzQk?=
 =?us-ascii?Q?AWMnrwGEdLnPmMvspGLQ66iLkR945YJk91V1GkdoFMPoPMFHquGrKv1iIlN+?=
 =?us-ascii?Q?GjqKCNuy/JNk9kStVjkT7RW0lgWoo0+rEaDj4g2Be+HBvnROa7cIau3bBHs2?=
 =?us-ascii?Q?KoCqeU9xVzoHXyPQzZdZaHWXgofHoHJMquOnRQIYkq+JkKM8lG2IoVpu2nz/?=
 =?us-ascii?Q?t7mAFrLyfC2mrNWlEFKUVhKH4C7zNJ2Q0yOPne4dOhbNYLspltoCFUXtrBgb?=
 =?us-ascii?Q?MbbTEiKlMX8hDod2cbuUOsNzKx7CFGD+GT6dekb93pWtzYCh5CipI9ZGpXwR?=
 =?us-ascii?Q?/dzFApfUnpRqcnAcqFc7K6rQo0eBzXZuR1G/19z0WxbDpVp6ipTCAFwJAHUO?=
 =?us-ascii?Q?BEulCPL0CWmfb8pH+ElcRFuolmd03AvF27pCFpe2b+XXOWI4JAtXPs0Yb4cs?=
 =?us-ascii?Q?nPmlt7CB89lw1iXqE8uenPEJPwADUOUDKc3uE9rK/Ns8BjRkKqYeJuX47O6B?=
 =?us-ascii?Q?0ELce/ze5cXdxqW0tjxRKqMaeDCNUAAu64SUq/ylM+xdEF7ehipaEOJP34ES?=
 =?us-ascii?Q?4mAHzrPepLp5WTOPOil0/xJ8QUe2wy1knsqBKvMQPlTwgdkiMRiqp1vvksRg?=
 =?us-ascii?Q?L+5jRu5V8vPQdViibYpguQIgBKk0GSfgmogrlYY/uWXIWk/MCYzMLv8oBLbv?=
 =?us-ascii?Q?McFWjW9hITpkuz1PJcT8ZHsl/z9p6l8QhTHlcbjLG8ic3W8UbsdbucVc4Pm7?=
 =?us-ascii?Q?P2UGD7IXW+QobJQ9vdUA0DTDoZobVIc4Wg9vJPG51Xe1CFbyvd9dr86cuOs2?=
 =?us-ascii?Q?QL8snl19Zpm2D9o4aEbmZgTPqxV+OcodCVse+L1x+/o615ItQsiedgkviR8K?=
 =?us-ascii?Q?oKTNZmeV5dCvQJ+wCUs+QW/GtO12DEBXTldsckLk1V7QogRUb9roDKZ8XXmD?=
 =?us-ascii?Q?c+SeibWyYnuxD5q3fZyq2eFwsy4giqurp4m/JSDhEGkBQnfZVgDQ0PmxKXRM?=
 =?us-ascii?Q?YpdJ0BHOUR6lIOb0e07vM60vs935PPmZ9Zbw5RfpOJJhb4ejNBGY91507Hmz?=
 =?us-ascii?Q?JxPft/xWpWsO8T6m2zT2844ZYNskC6vEj6fR3a65e8vp65CB+YsCDMVH+wSK?=
 =?us-ascii?Q?CvhrpFzNbZ/ZTdbwN6kpt1CNtZpc3zKkMnMumJ34TExaObWX7wlG5UeYg0oU?=
 =?us-ascii?Q?qxu14i0I6IlvkWec/p+7xqCTU1x4mD/DQfunlwoDTXwGJyJQA/qHygKg/l+v?=
 =?us-ascii?Q?+FHcVU149BFrrlxVrpQ+H9EnOX511ZKb1Oyb7AttoQzsA68p2kLupXg/E099?=
 =?us-ascii?Q?foyxHxJhePpOnFiG9CxZPND8OmiMKRrlkun99D6nSvO1OpReDRkeGKKIWc4O?=
 =?us-ascii?Q?0FF80SftFZipk6gyiJd+JNRMBFuybKvCmjOtrNaJEabXrpYL3l8pr+3Yp6DH?=
 =?us-ascii?Q?eCQ2b07XM2lqFZYpMqHxx0o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7e15be-b086-40e8-46f1-08db35d877c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 13:20:04.1055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQWSJINmi3pz6tTivO9x4GJAFAHe/nIS77a/5XXJnI2GHslf+7Sr0jaC0b9ve1R0JwuHWN3aivcV8TmmHey1VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5517
Subject: [virtio-dev] RE: [PATCH v12 03/10] content: Rename confusing queue_notify_data and
 vqn names



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 5, 2023 1:22 AM
>=20
> This is not much of an improvement.
>=20
> On Wed, Apr 05, 2023 at 04:06:50AM +0300, Parav Pandit wrote:
> > Currently queue_notify_data register indicates the device internal
> > queue notification identifier. This register is meaningful only when
> > feature bit VIRTIO_F_NOTIF_CONFIG_DATA is negotiated.
> >
> > However, above register name often get confusing association with very
> > similar feature bit VIRTIO_F_NOTIFICATION_DATA.
> >
> > When VIRTIO_F_NOTIFICATION_DATA feature bit is negotiated,
> > notification really involves sending additional queue progress related
> > information (not queue identifier).
> >
> > Hence
> > 1. to avoid any misunderstanding and association of queue_notify_data
> > with similar name VIRTIO_F_NOTIFICATION_DATA,
> >
> > and
> > 2. to reflect that queue_notify_data is the actual device internal vq
> > identifier, rename it to queue_notify_id.
> >
> > Reflect vq identifier in the driver notification structure by renaming
> > ambiguous vqn to vq_notify_id.
> >
> > The driver notification section assumes that queue notification
> > contains vq index always. CONFIG_DATA feature bit introduction missed
> > to update the driver notification section. Hence, correct it.
> >
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> >
> > ---
> > Some side notes:
> > renaming vqn to vqnd is even more confusing because data is really the
> > queue identifier.
>=20
> Clear to whom?  Why do you think so? Marvell who pushed this feature said
> they stick some kind of constant value there which matches what their
> hardware expects. Sounds like a valid way to use this.
Spec currently has described it as "identifier".
Snippet:
"for example an internal virtqueue identifier,
or an internal offset related to the virtqueue number"

> So no, not an identifier, and in any case "vq identifier" is a really gen=
eral and
> useful term, I would rather not burn it up on a baroque feature that almo=
st no
> one sets - for almost everyone else this is simply vq index.
>=20
> If you really insist on renaming this away from "vqn", maybe
> vq_index_config_data will do, and we can add a comment /* Either vq index=
 or
> vq config data, previously named vqn */
>=20
Vq_index_config_data also aligns with the crazy feature bit name.
So I will use that.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

