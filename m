Return-Path: <virtio-dev-return-12264-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60219C88C8C
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 20:53:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 82D2EF3F47
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 20:53:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A051986614
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 20:53:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6E56E9863FB; Mon, 17 Apr 2023 20:53:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 59C639863D7;
	Mon, 17 Apr 2023 20:53:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9Igsj07dQ2TRwS5nqH3v6PNa9I32K3EhAiSJRr4XXSe0RUxSL32F3R/sDJFdqhOlASxLR4j40xqLwaLg3YzSDn+5hKoGwMEsb6mFyiTY4ltDFeqyGWWTeYb5u2LpuGXri0a/kMZyWhEHOn9ihcepRmpfe9JoboibFwsGPI+/9tNDjJW71K5oZK/67BTyFDPa8MsAuO6LLeZ6bjB34DoUm1JyjgbpH+OPZ8fbp/1/KcnMXTuo+/ROB/Vb2zBr2oGKOk1Z9P1TeBjP9QxYQMnKUrIWMSd0QL6hZRFvmMtDiaq3PDzFo9MA/bzjdcCoXYHYGiiPH3yY1jCa4HXnKMT+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZsaBlTql3IPjmqNvfo4qRfy6OsTfVdrEuyAkvewRjo=;
 b=SuvU2k8abN8hMI+GIkR6u7TBjm6eED39VnCFIH+AtN3xn1EJOasdDg+LgRfWSfe/e6ZxiuTD9nsLZ6eZimU98oQ0eJx/4NcFBF/uSvWic6g2vOsWtI4dEyjScqaHpNIcZhGxd7Gx7Fn+WIfgS/DeakZMoeO1daA56zICmOdrYDw0Wsk65rTTenP8TR4md3bb7rVYCKYlZeWoMxD80kua6AseTXYAHqEddQuhjPL6bcBhCQvZ41cv2Bo+LBagNJz7YPANkbrSj0gKE6FImxuVcne5ihdV0HYqvnP1c4+kWxxpfGCoPstG0nQW+5BC13RLv7GQhsYEl8AmqljThMKjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Halil Pasic <pasic@linux.ibm.com>
CC: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-dev] [PATCH v13 03/11] content: Rename confusing
 queue_notify_data and vqn names
Thread-Index: AQHZbKsw5xtQpz9Phke1SvpgoB/q7K8u476AgAEd6fA=
Date: Mon, 17 Apr 2023 20:53:32 +0000
Message-ID:
 <PH0PR12MB548148EDDB407D4B1A3E316ADC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230411192341.751841-1-parav@nvidia.com>
	<20230411192341.751841-4-parav@nvidia.com>
 <20230417054149.5d7f62e8.pasic@linux.ibm.com>
In-Reply-To: <20230417054149.5d7f62e8.pasic@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL0PR12MB4932:EE_
x-ms-office365-filtering-correlation-id: 5f3f53d5-e6c9-4250-a10f-08db3f85ce4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 g3o+zKgjTVKfQaBxDUijNB53KEHOlmvFl6ZycRHjBbnNKdQ57trwUhPXPDahEtieimYg2iZCtWGC2pJogBi1nS3YrS0pZf7CRp3F5lfo3zdcatTrsQUAQnRD75SP4nTM16QIqGUkf1EsDM+wkExN5EZGiAv6vXlosjbFol1a+baxqKGASyrTEfd7gcfJHV3EQsxYIJ7FKxQlYQtswplyS6q+g34M4YFVxd4EO7tYKUrl6m7sVyBz8BPYH8eYS4VNFg0/tfhtl9udkxdYlD4B7JWtpF9P8lJPPC+zHqwuIZm6H2E+1O43xojkePZyJ6pTQhT+lhRuF0NuI4Nos+359MpKU6nRFajOjoI5YlDyxPRqINv5UBAWQ+1KQFqvBz20KdZCGRFqODdt/YlsOu0dGE2ZJDlBw63sjG1QI90bFSxtc4SDPFbEvSxxuZ7tsUeOiIBhQnJINr4dBfrAkh3+F1khIsWHboznOODkFuU5sL4lswO7bz9f2Zn2GM28SOSUN0m5wF4jI+i9MxC7pAm78ZoVZIxqC5plnMKF6IccvYsx1J0oo6Zveu+sUDuuAMWdi4RJpNUXIYCV/wzzKgyzXpjshL7SaDBy4qZg0qr+CxO6bJqKV9Z2sVUtP6+GDx18
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199021)(38100700002)(8676002)(8936002)(122000001)(38070700005)(52536014)(5660300002)(2906002)(33656002)(86362001)(55016003)(45080400002)(478600001)(7696005)(71200400001)(54906003)(186003)(107886003)(9686003)(66946007)(6506007)(66476007)(76116006)(66446008)(26005)(41300700001)(316002)(83380400001)(6916009)(4326008)(64756008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pMiF92Ukoi2nxeDkI0NWD1O9uoGS8Gm+kK5TffZy6pw4W8+VMRb66WQtcnYO?=
 =?us-ascii?Q?6rQkcT2qZ5K4be5NXtWWH+E6ckAjU05JQEljiL21Bk0LV/C/S8aEyymhQi/s?=
 =?us-ascii?Q?wYsu0scgwkebs6skFGAOp4NPIop/24l+2RlWr2O/m6Sw9LZjn23nneb2pMHa?=
 =?us-ascii?Q?OM9YXofXWvgwcGtDv0fOaAi1InkWHmQKTHrg6XT9UZijmTgQrg4wE76CvdIH?=
 =?us-ascii?Q?MCRNh26Hvy6SlMQ0rxLt+x64HduX4EqrKbeY9JB70BIm9XudNilLrxV4b/Al?=
 =?us-ascii?Q?jM5hIBLhNhqsuPa+X2/SGWrfLnZbyrCCw4M1nzHTVcVBhIQVHWysUjyKdsU7?=
 =?us-ascii?Q?5a3yczN3++EFWpuAwEDOneZsplk2Rf/b6v9JgbFmfsQ4aWzYL+6e4VrdzxzF?=
 =?us-ascii?Q?w/GY/YY7Qzdbx0gVLGaA7utO1ho72bMEcaQOKZF/9lw1uCCjmL3Wc5GrNK4d?=
 =?us-ascii?Q?mTjScD5Ou8iSiRhMr6loLSvQZHKfSwFVHx/QWi6n8T0JR9hryLqJLa+lnYqU?=
 =?us-ascii?Q?WjAGHuHR++UGZjIrS214iBU6Kszr2viXOIqXLBnmgXsjlup0gxjC620bUHQs?=
 =?us-ascii?Q?Ap1PJ+hu0nNjlpNlODLtvRk9KftuRno/HCrcuBdRzSyO1fGW8hF3o+4Du95s?=
 =?us-ascii?Q?EWrCTlS67V00eSDmKQTus3Y+FaQZONB9KRUr13kEwN2fNxv5FPSEnxsaykQL?=
 =?us-ascii?Q?wzT7nVBXEEDxFyhscHFp+i6K3j3rW9j8Dnsr4WBvurBq+b3uQeLkMa+gUkXe?=
 =?us-ascii?Q?l8vxOKlbBc9kMEzG7SSnmF0fVAO47nuETr1DDXmEMHEiWIXbGI0GAudANTPk?=
 =?us-ascii?Q?AwFfsYHJyP3kI6y61Gus/cPrGg32HdOD4aeCy3Zq2eG1MUd8WSiEFyzmpNwB?=
 =?us-ascii?Q?Av/LOYG9k1qL05+831+UaBOcEX80RrCcOWlchPxAxQ7k5G1N3tWRbSfttaXj?=
 =?us-ascii?Q?RY11nTzF08tLEB1d/8642NbVufVeedvI8Z+9/MyXR9SkskaJjyDHz4gFN200?=
 =?us-ascii?Q?BVIyccZLglRTSzaoS31UqYMW77/B8rsYbWfrWhESDaj1Bsil8VvTAt8Jyhf+?=
 =?us-ascii?Q?uQBSODCy0f8CKRolBg1A+/ls3J/yxFyswo/Lsu06Qh8WjoZVHTrGOwdyt7Vy?=
 =?us-ascii?Q?AEr2lN+ko1tTeuGWmNzIpXD3uN6w9fAnWQ8qML/O4WR0l9tm8htzlMjqox1/?=
 =?us-ascii?Q?OifRx0xUxAoHf8cDM1YVIcU1TeAlR9yfuEkVW7uRe02Nxh36MlAQ9YLnSCzX?=
 =?us-ascii?Q?mGOw9veItFMg6mJzT0CwvXhFjmrOI7y96mb6ZdfS6gkHr2WSMhW8efRsMFS1?=
 =?us-ascii?Q?Oa5163xLgtwked/FVHBpNy7RrAsX8LKyyBJ8d8Z7t9yTPapcJI31t2cFXVye?=
 =?us-ascii?Q?0rKhbSLZ8m3Z9HNJi/iGinh9/Ii1df5g0oCLjYydIjr1ZOhLkFEVO7Vwd+H2?=
 =?us-ascii?Q?daJ7JhIOnExKbF64SoeFUg4frs6zzcse8lTfCZUai7Ym/p4xrDbjhdDx02x3?=
 =?us-ascii?Q?JHh37RenIpONv4RpUM5JSwjOd4sm4u/uXvYRqExUbpED2S3yxzf9cH3SGElT?=
 =?us-ascii?Q?S17U+HeKOvUwjmUPKew=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3f53d5-e6c9-4250-a10f-08db3f85ce4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 20:53:32.7374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3WERQfOnMoD6PzYHouhWaZ2Dhf0bOm0vlIwQT7obYEL/xfM5slA4cdUa7t7cu6au+oEQBSVNLM/klk4O/CUcGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4932
Subject: RE: [virtio-dev] [PATCH v13 03/11] content: Rename confusing
 queue_notify_data and vqn names



> From: Halil Pasic <pasic@linux.ibm.com>
> Sent: Sunday, April 16, 2023 11:42 PM

> > diff --git a/notifications-le.c b/notifications-le.c index
> > fe51267..f73c6a5 100644
> > --- a/notifications-le.c
> > +++ b/notifications-le.c
> > @@ -1,5 +1,5 @@
> >  le32 {
> > -	vqn : 16;
> > +	vq_config_data: 16; /* previously known as vqn */
>=20
> Is this where the union was supposed to go? I.e.
> something like:
>=20
>         union {
> 		le16 vq_config_data;
> 		le16 vq_index;
> 	} vq_index_config_data;
>=20
> (You said  in the v12 disussion in MID
> <PH0PR12MB54812C754ED9063E34E06E1BDC9A9@PH0PR12MB5481.namprd
> 12.prod.outlook.com>
> that you are going to change vqn to the union of vq_config_data and vq_in=
dex,
> although vq_notif_config_data might be preferable).
>=20
Ah my bad. I again got confused when writing the patch that this structure =
is only for notify_config_data.
It is not.

I will fix the union.
I will let be unnamed.

I will rename vqn to vq_notif_config_data.

> Or did you mean to do
>=20
> +	vq_index_config_data: 16; /* previously known as vqn */
>=20
> Of course, this has an impact on the rest of the text...
>=20
Union is more readable. Will keep union.

> >  	next_off : 15;
> >  	next_wrap : 1;
> >  };
> > diff --git a/transport-pci.tex b/transport-pci.tex index
> > 5d98467..53c8ee6 100644
> > --- a/transport-pci.tex
> > +++ b/transport-pci.tex
> > @@ -319,7 +319,7 @@ \subsubsection{Common configuration structure
> layout}\label{sec:Virtio Transport
> >          le64 queue_desc;                /* read-write */
> >          le64 queue_driver;              /* read-write */
> >          le64 queue_device;              /* read-write */
> > -        le16 queue_notify_data;         /* read-only for driver */
> > +        le16 queue_notify_config_data;  /* read-only for driver */
> >          le16 queue_reset;               /* read-write */
> >  };
> >  \end{lstlisting}
> > @@ -388,17 +388,21 @@ \subsubsection{Common configuration structure
> > layout}\label{sec:Virtio Transport  \item[\field{queue_device}]
> >          The driver writes the physical address of Device Area here.  S=
ee section
> \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
> >
> > -\item[\field{queue_notify_data}]
> > +\item[\field{queue_notify_config_data}]
> >          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been
> negotiated.
> > -        The driver will use this value to put it in the 'virtqueue num=
ber' field
> > -        in the available buffer notification structure.
> > +        The driver will use this value when driver sends available buf=
fer
> > +        notification to the device.
> >          See section \ref{sec:Virtio Transport Options / Virtio Over PC=
I Bus / PCI-
> specific Initialization And Device Operation / Available Buffer Notificat=
ions}.
> >          \begin{note}
> >          This field provides the device with flexibility to determine h=
ow
> virtqueues
> >          will be referred to in available buffer notifications.
> > -        In a trivial case the device can set \field{queue_notify_data}=
=3Dvqn. Some
> devices
> > -        may benefit from providing another value, for example an inter=
nal
> virtqueue
> > -        identifier, or an internal offset related to the virtqueue num=
ber.
> > +        In a trivial case the device can set \field{queue_notify_confi=
g_data} to
> > +        virtqueue index. Some devices may benefit from providing anoth=
er
> value,
> > +        for example an internal virtqueue identifier, or an internal o=
ffset
> > +        related to the virtqueue index.
> > +        \end{note}
> > +        \begin{note}
> > +        This field is previously known as queue_notify_data.
> >          \end{note}
> >
> >  \item[\field{queue_reset}]
> > @@ -468,7 +472,9 @@ \subsubsection{Common configuration structure
> > layout}\label{sec:Virtio Transport
> >
> >  \drivernormative{\paragraph}{Common configuration structure
> > layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device
> > Layout / Common configuration structure layout}
> >
> > -The driver MUST NOT write to \field{device_feature}, \field{num_queues=
},
> \field{config_generation}, \field{queue_notify_off} or
> \field{queue_notify_data}.
> > +The driver MUST NOT write to \field{device_feature},
> > +\field{num_queues}, \field{config_generation},
> > +\field{queue_notify_off} or \field{queue_notify_config_data}.
> >
> >  If VIRTIO_F_RING_PACKED has been negotiated,  the driver MUST NOT
> > write the value 0 to \field{queue_size}.
>=20
> > @@ -1053,9 +1059,9 @@ \subsubsection{Available Buffer
> > Notifications}\label{sec:Virtio Transport Option  If
> VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
> >  \begin{itemize}
> >  \item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the
> > driver MUST use the -\field{queue_notify_data} value instead of the vir=
tqueue
> index.
> > +\field{queue_notify_id} value instead of the virtqueue index.
> >  \item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver
> > MUST set the -\field{vqn} field to the \field{queue_notify_data} value.
> > +\field{vq_notify_id} field to the \field{queue_notify_id} value.
>=20
> Seems you did not catch these with the s/_id/_config_data/. By doing the
> replace one would get queue_notify_config_data, vq_notify_config_data and
> queue_notify_config_data respectively.
>=20
> But that still does not seem right, and the right answer depends on to wh=
at do
> we rename \field{vqn}.
>=20
vqn -> vq_notif_config_data in the notification structure.

virtio_pci_common_cfg.queue_notify_data -> queue_notify_config_data.

Better to rename

VIRTIO_F_NOTIF_CONFIG_DATA to VIRTIO_F_NOTIFY_CONFIG_DATA.
Adding "Y" is not going to make it that long. Field names will have some co=
nsistency.
WDYT?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

