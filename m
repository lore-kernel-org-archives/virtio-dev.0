Return-Path: <virtio-dev-return-12553-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4D7C7EE21
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 18:33:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7C4813309F
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 18:33:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 67F959866C0
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 18:33:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 552EA9866B3; Thu,  4 May 2023 18:33:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F5989866B4;
	Thu,  4 May 2023 18:33:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7l8rJrX62Ik+p/o/jJaSnhwThHjlGOx8QKxFCFRL4Uff5UFJsY9RMA6KpFC5OHFUYEvROPUVlaT3Ngt7IW5K8U9/BrwqyU/zCsn7RB9PEa9fg8UWNl2rdoTAgwqZ6sDwQY39BkUfTT8dPZOYxWC2xUqXXdmv4JB9yZRZw5KJ0232ey8Gokc7hoNgTC8QVbEoEdo9kc081upgmFI7cNpzYBNVnxE4+lKV08cAhYJxwuwzZLRQMR97ExmtfFkjxz9EngzZa0bMJgX2aFWrDkh3WloRiaNFAUqREkMxs2U4vTcOD38LWJ4R9kYc5rD/cMAsyrDLWBudJmo6Fr7FpyEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QCvd63IXCXIfEssmEXA4hzFJQPYfyngmaFECCd2Vw4=;
 b=I75H1woDcyKj1Di/f0BbvCNWKipeJe86H4sBBb5hpqtec5iK8A+u7gmJPwfu4Ds5fU0eYMkzWz2Indt0ygBaplFdHxKUzACszRC45X51iVkMBpKY2RgbTn8rlK6IH6lI2HY8jBQ8fjlR+edQXq0NdvAy367EUVvSwbj4aikYoBumTvIIfJn3/+5TbUKU36JJP5roz7ZibouWtq8VuswFiKPX+mLCBUFMnsRk9sBCqWEC3w7tLd+5clp7TmwXvxSgdm69OBTNKGN68j/BdhKWJaO5xBqROt1qdV8g7F+mx76/bEg0ZtND2yMEMtW7YdZ/Ix6hsgYNZ0XJJGFufUVhFw==
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
Thread-Topic: [PATCH v16 03/11] content: Rename confusing queue_notify_data
 and vqn names
Thread-Index: AQHZfjBm/WBwopgBd02gfjAA00VqW69KLOcAgABDVWA=
Date: Thu, 4 May 2023 18:33:38 +0000
Message-ID:
 <PH0PR12MB548100E1C4AD64EA35E22772DC6D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230504022959.547025-1-parav@nvidia.com>
 <20230504022959.547025-4-parav@nvidia.com> <m21qjw5fyh.fsf@oracle.com>
In-Reply-To: <m21qjw5fyh.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA0PR12MB7003:EE_
x-ms-office365-filtering-correlation-id: 969995df-8d00-4f01-2da1-08db4cce13d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6l0E+ZdUN0vAD0d0UWEWBUp5oOj0eAhI9aU4VoDcagzNVdah0EdKEMyD1Q7A8e/fulT7gM06EbqqdKs+N6hPoV0e7yL7/BQu1VtotNRjnVrvEp2kcvyrsy9MseOPu3SS+iARiU4Q6K2TeNEEz0cUac23xhhMtAD71QuhVwcuDbFhoGUHk0HoLJFPy8jl2vIwrde0yn4JFIqjvmBKAUcSma0elHmts7/ghX/Cz07S8zyEZU7YpB+nZpazQbaVeiUVtudZCFUoII3+V18stxF44TiQuqx9to4D2qmkSj+5EwJE+/+UrUvlLXSWLIAKwr31bf+JSpjD/d7u5h0fmINDIaDMS5LF9tRyd+J+1ev7dIROGexrjax2V1YkLPwqBPOGn4jg94Lf3KmnR38OJ/AQ8NTehgUlEIA66NpcoFbKt8hlaOHSH7kLn5sXKQt06vJevWZG6q3Xsyi5DVb5OA2h4djcXQMuXNvFqC9jKARRIsjLfc2vtYQsVRIpE/AwPALShGrspXSaSVklma1XJDyNP2w782S7Ns8PLtUtzwNpgMg0r0YNpz1Zbs8y0XllPivzBw85GcONSKp8GO0OXAcgENBTQS1YsRbLCk2rdNZAKkBqd5q/VUW0lFkoZs4sZip8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199021)(6506007)(9686003)(186003)(107886003)(2906002)(52536014)(5660300002)(83380400001)(8936002)(86362001)(8676002)(41300700001)(7696005)(33656002)(122000001)(55016003)(54906003)(110136005)(38100700002)(71200400001)(478600001)(316002)(64756008)(66556008)(66446008)(66946007)(38070700005)(66476007)(76116006)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9YVW4QPFCSdOV+a5g8ZnNUVUkxYEM9On1UAJmB5y5ta7lXhramEFuuOfd9xm?=
 =?us-ascii?Q?CnZ4G6XoeDOjOGf2M+Kz6HUFzWDyW4m0hwoKHLmby7Q0ju7XfDA2s917x58z?=
 =?us-ascii?Q?5RENgFrY2nA/oKZuKKkxJKMEhrQ1WSKvvfuIjuZQLA0KlnpfrJ2E7km0yDv4?=
 =?us-ascii?Q?VNN+7xb/Vd2qEAVOG9X1/zCvZLNbOSvy5BkWYNaNa/W9W2Op/OduN36T7Wml?=
 =?us-ascii?Q?z4lKO68RVsZtLBwSdbH0+6CZ7rQFaXzobTrhNWuvHA/FT9uawrIWISFMz9JR?=
 =?us-ascii?Q?S3KqUpPt3pTNGq7ccJ34ggq2VK+JRzTxbUfW9nhr7k3+rVr3/oFsJ01tX7jL?=
 =?us-ascii?Q?IKOXopDXvpJnB9kFQ6Yj1UMQDeMVqJ8dNu3GZKHcl6hP7VQT8ChiaADvGsSY?=
 =?us-ascii?Q?iN0gKy6hJQ7+HjCjW3JwZo7GjX+WXk8+UyXxJaxJfy84ixKq+Rr5UrjfMV1O?=
 =?us-ascii?Q?63VZyDLEHXHh1e5oevzU/rlXFgI1987eCrgWfeoiGOuNTOcCqWm/hQy+16jl?=
 =?us-ascii?Q?q0lTXaeULwarfRKfdmX0itL3BU0V7RBVEvv6CHPtmPnqL2htPsiGV7eUfG2D?=
 =?us-ascii?Q?VnaEAeqjdpk0L63QsfYcEq7DFc8BEZmSYynKpaExl4WHfCFo36tiJdG3+m4K?=
 =?us-ascii?Q?pqX5zhK08yAVV4Jh7xgPAHY0xCYOxJwfPP/6cQdTbxWWrzPrUpQX7qBQcR43?=
 =?us-ascii?Q?RaBQewpgjqION6QHOAapoy1JwalQHaILadLblXmZYg85z7WTCutt181MZW9c?=
 =?us-ascii?Q?wwh6hVPdNUh8wwtunLokWZNFsmebBidNGgvOAvCM8H6mOuUrPAkjWaecJpPj?=
 =?us-ascii?Q?dtRrHvwWGWq9OzRiRmNNdnAH+AH74xdqC7RY3sZ9cjs1WyoYPyE2pjpA5v7u?=
 =?us-ascii?Q?gYYvxOP6sjsB7hOl8pDaN53+nQugllAY/2Y7bst5KYDGDplpnRExzPgUC9VS?=
 =?us-ascii?Q?X1DBYTwvrKSo3u4GBSyZ6gcNpJ16zHMz0YLH3YYRgAjnyRphMLl6OhZRNhum?=
 =?us-ascii?Q?ttrHoo0bA566EWF9hiRPjN5LQiDBfuODGUsgXFLTLuJ1wlPaABOba+XAoufX?=
 =?us-ascii?Q?U/2iD2zl+/M5mFrXGfp8kuK8tBNGhCX+YOYa2LfgGHRbzNQ7yZA0eyQsqDVp?=
 =?us-ascii?Q?8gbsMf9pgsG135+VOuw2vADGQlgQbdMZAQiAdNAcax5+Lc+IIwvU6kjHPWZp?=
 =?us-ascii?Q?KTvpv+AKxz2kVdnCT3NVrXbXerkBTJ6Z9aKjb7keZeUoJ14ehbyLczNLS5IZ?=
 =?us-ascii?Q?Nki10ZVX82P6v3qh1B8ORa4U92WSLbmn87x5oN2Fwq1Y1U0uKiW7f3poB70r?=
 =?us-ascii?Q?/Nfv5eYqC6O2eR3BILKRw92yguv2J6X6CVYvpdgl7fbXk7PprVi7Ij5rMGMc?=
 =?us-ascii?Q?0VDVjCz6rNwpjSW5l61SJxCbrVKKLnv2WA9MhF9C0r3UT59pGpCw2yVKvo8K?=
 =?us-ascii?Q?tClcOG5Ht8GsPK5AcjPu0AT8DXaYT/NG0ZMkX4A0/nGHCerfJfW8VM6ARjzz?=
 =?us-ascii?Q?dlF7bMn6LeK6BN7xzBCVm0p8fXh2RKMk98iY9WPLwfb5hTMKUcYjCTjDEsxr?=
 =?us-ascii?Q?MSgOeXckDKAReKzclXzpSdcxWEl3WtVPgzokvp7VfmqboSJhBnLOicRBpGWj?=
 =?us-ascii?Q?fDwxPijTSCVnPvEMl0RV7yk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969995df-8d00-4f01-2da1-08db4cce13d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 18:33:38.2049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMhlaJW0PEH+7kp8C+iHgPNJMqu1zTlWBmZoVaSUvq++ypJz8R4eeGhBA0lquh4WafH0kH9zo/BlldlnVRTgCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7003
Subject: [virtio-dev] RE: [PATCH v16 03/11] content: Rename confusing queue_notify_data and
 vqn names


> From: David Edmondson <david.edmondson@oracle.com>
> Sent: Thursday, May 4, 2023 10:28 AM

> >  \begin{description}
> > -\item [vqn] VQ number to be notified.
> > +\item [vq_index_config_data] Either virtqueue index or device supplied
> > +      queue notification config data corresponding to a virtqueue.
>=20
> vq_index_config_data doesn't exist.
>=20
> Given that this is an anonymous union, perhaps:
>=20
> \item [vq_index or vq_notif_config_data] Either ...

> >  \drivernormative{\paragraph}{Available Buffer Notifications}{Virtio
> > Transport Options / Virtio Over PCI Bus / PCI-specific Initialization A=
nd Device
> Operation / Available Buffer Notifications} -If VIRTIO_F_NOTIF_CONFIG_DAT=
A
> has been negotiated:
> > +
> > +If VIRTIO_F_NOTIFICATION_DATA is not negotiated, the driver
> > +notification MUST be a 16-bit notification.
> > +
> > +If VIRTIO_F_NOTIFICATION_DATA is negotiated, the driver notification
> > +MUST be a 32-bit notification.
>=20
> The above two should be inside itemize?

Both suggestions look good to me.
Given rest of the patches are reviewed and it is already v16, I think I can=
 cover them right after this in editorial changes after merging this.
This way the majority of the work of this series and subsequent patches doe=
sn't need to wait another week.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

