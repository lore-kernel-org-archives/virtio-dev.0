Return-Path: <virtio-dev-return-12365-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F9FC7618E
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:11:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1507641EED
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:11:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0D0A09863A5
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 16:11:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 013B6986350; Mon, 24 Apr 2023 16:11:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E13B798635B;
	Mon, 24 Apr 2023 16:11:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qk0QryjRufrB39qdS51dY0ihaMtqnwQG71qu2fAtek3sg+evSusKXsdyf2vE4UapXqawG1/2r8Z9tHvKqXx0/ylz7PXb1I6C6RjgDk0v0m1u6R7mYXPvDrwVs7mHszJKooR5W/X+yFD1L3YSmIjbejQZjZr8Os/HM9Cwv8nUUUnGtXNvlz0dTvGC3iMFtDgomvZmu29TRacszUwxT3ZUpuQZ9j72b3OTh0jB6/MhTqy+GefqJEARWTH34nFVA4ZisGjlUqQ69Cm8Vo6ufX5GtatQGz5AwGl8oCF50+AZq3pmW/n1jUsI6e3/Q45cIhQVnJjEIHROCf4/kTKWPgxujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1yqEinAsSxYFLzRP+qWzPAwHKJ0FI2j/lNEPwAwwoY=;
 b=U0EptSrElmpqBdSnwwNBMnA0l0T8rJsJ227pCQrngfJhb9FpltMCH+tRcaHZATn5MBpcmTs0K3yTgRn/Dq7doUl1Wq+MvNr9OqMdx2QgqR+9jfTnyryIs4HDpB4JCncQVUZ1XqGJvj9o2ivB1BPTks3R0oyI2FOYF9SJ9lqgQ/DRFzuC4QI4ppNXxIlHHqV02iAPkLmYBR1Rb4jKXexNZqHd7riwcFhIIYmeiYdLF9UPF4ZBbzZL3D4GzzKYkABcZJVB7Pmof8sx8iFMRxYXFytA8i0tSATM9nSOufEma7YxmrJVZ5vOkf8TmCD7kf1IKv4ISAHbJUrI+Cz8C/aAqw==
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
Thread-Topic: [PATCH v14 03/11] content: Rename confusing queue_notify_data
 and vqn names
Thread-Index: AQHZcmDYSdH4rQyZ+kun7g29R+Zrma82XxSAgARAGHA=
Date: Mon, 24 Apr 2023 16:11:27 +0000
Message-ID:
 <PH0PR12MB54811C5B35E510276227C5CBDC679@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230419014639.919458-1-parav@nvidia.com>
 <20230419014639.919458-4-parav@nvidia.com>
 <20230422003757.0c1ce85b.pasic@linux.ibm.com>
In-Reply-To: <20230422003757.0c1ce85b.pasic@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB7439:EE_
x-ms-office365-filtering-correlation-id: 43b8afd0-eb52-477d-cf73-08db44de8eb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9u/N+X/WbCj8a06rwNUPJByGkrbN/jfg7CwYMpGNgZPeiUuKsLWxTUM/Nsay5Fc5ZFHk3z2izWtGkoxZHLh9MeAUGrM4YWM1JqDKPqxD6Kk63DxL0jvo9yyri74aO7DsuAb7zmrJw18Zg+jCoYwdpmUiTPJ6E6PZIFIqrCAch8XUL4P3g0DaWZziaZTq1NgAJ0yQQKTEA37We/wGweNihCxOliZbFS4r65Rr3N2s0z/NIDrFopeGLvVpk3CJgVzuuScZkqoPS8sobAOfrr9Iq7M041eMMFOjUQg34V9SED92TDpQpkgMAibUP07GNomh2lgjJeMHUOwXwNe/cjqFZcb7eyGbi+3eShf/8cO1lBwYZJc4QkNVRTQRjXYeE9DzZYNZfwFCdndhPaaGwrTTDj/HcS45lcNI1VV883XeGwZrE5YpbGPfMFvGWdKd3KFiMcFtCJi6H1NVyYFetR6Is1NR/620UABIpfCJNb02n4fEBPbW2jdsN+ZvmYXCVtp6NkE1wFxEsmSr2Jcb2bnze3aJhmGqW632n+Cg8rP6NJvBbOY8Chm3v8SGgWzOz8r0AcfyhrYnVMZhYLg9HNzf9Vb6hgl+sx3vFgQFqdQ8T27PS5/mKZXQedABKhv54FUq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(76116006)(7696005)(64756008)(66446008)(66556008)(66476007)(66946007)(71200400001)(6916009)(2906002)(6506007)(8936002)(55016003)(83380400001)(186003)(8676002)(41300700001)(26005)(9686003)(5660300002)(316002)(33656002)(52536014)(107886003)(38070700005)(86362001)(54906003)(38100700002)(122000001)(4326008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3q7RxSHh9YcUYtNYn/hq3LRn3f9wNyoA/Av7DbONhM/UDwh59xL1561YJLY+?=
 =?us-ascii?Q?MDgTJ9pd6JKxmS4oQrYhd2AtWsQITOwKlbsFhrIj/s5dOWiNRZnLCD5U55H7?=
 =?us-ascii?Q?lWlm0dnk76fCH++EiuB/GVcyMJSb6tc2H7C3qYPTFZxr5S7U6+8IY6rezn4p?=
 =?us-ascii?Q?LzIIrvWliCRksruW2rErGOSiKro3yf+vyFtBpJqY1Ugpv3ae3CgwCea4x4uO?=
 =?us-ascii?Q?L/LNTmxau7un0j2Fx5FCBaoX26rKRvAFE+gYFmumACxkrA5HQrP30vPTwdyf?=
 =?us-ascii?Q?pG9lO1Y/XaSjOrTz9PG2DwhuUBFkggy2IgDUEVHJu5FyafHUhyMB/OdKA908?=
 =?us-ascii?Q?Qj4+EM8/icAAwHbaVA/YNe7NrUSRbKI2FgyRq0C7XwWdbhsWxhGYe9kLxjqi?=
 =?us-ascii?Q?M3bz5ntY++keoQqfeK/eDHZZASGPpa7CprkTjEtGzIooWkVnEKGsfZeRHXOC?=
 =?us-ascii?Q?fGy+eUITHICgfPSCW6ttFtjRPeGmXdiRMTCj0L0FIeW9+zo9Yg/JOAOmenRa?=
 =?us-ascii?Q?eFwn9jBqXcR5B4Tmx8NvoCKAElYwI5rexSUZDF8Q1WWSB9w7PdmZo+EShBE/?=
 =?us-ascii?Q?5m8Np04uJer21POprSv5zyjfJP9INMvEYwfEmXs21cld+51gt6C+mg6m/2YE?=
 =?us-ascii?Q?j4LbxtcTO5esZvVViIHP5hi5NKeZEQt+XUaXHdv0zAL7fTbDTW3kzwWDx2s5?=
 =?us-ascii?Q?YzrIG/hrwBiPHyH5WT4nIBaPZQQ9yH5k++3V19ES7kuKuleCUp8y4fXd9Bx2?=
 =?us-ascii?Q?xUDQxxUX81jRKiH0e343i04ymmlagztAfXfFAUxxdGHsCoVz3uuj2L3IWk3s?=
 =?us-ascii?Q?BGh1qCOzub+B+NF7z1g+rP6Avvd5hEUuOoONiC+aVIphtG2znZIBnEakp7rL?=
 =?us-ascii?Q?CapajjQDZF4Ci56Q9+amhz9kJCHmfNLhGY0ubi9330+kbF3EK0WHRr/jeASh?=
 =?us-ascii?Q?4FW7sCc63BD4TXk/OnhVk5TfKDvq+UqveC8W1scUohiol5ZXtYuHQTtDhJAt?=
 =?us-ascii?Q?Xs02DJP2Ahebm+7/IG1Y3WPkp5VRGInBxhqtRHVas00DT9oEaoaoCyxGNW/k?=
 =?us-ascii?Q?S9Gn3jET5s6XIbiGqNl5CPbz4SFCFOMqdpbMdhmwboPvtgxY3P6uYw8sRaZz?=
 =?us-ascii?Q?hhqos+/yYJxaqryWKL9yWVWfezK7QpNI1TI0TzMXF6xG7qVOOxJ0rEPYSxqR?=
 =?us-ascii?Q?C2V8FMSleGJAS03pD634z+YHY6YV5RRBhc22TttXnWQ1HoEwGHW79kwBRXau?=
 =?us-ascii?Q?MEeTynxQmJBW54rxG40GCWbmifdmlt8VbmQEugOmRkFoKfkiJ8t511Wc6vBj?=
 =?us-ascii?Q?mf+jbsbqqFhtCjXwss71RM35iQMrI1XJtsNN5zoNKBf7mlo5DkWFwcD6RKEG?=
 =?us-ascii?Q?yysvZHyVx7HHV+VH1G1ZeYO9KkBxUM0tbRvHUy4gPK9Nwe0FmSJusqvEfk5z?=
 =?us-ascii?Q?NyMRqDQVbYNJP1/4nXtH/HXHaNmkNQiSHxlODRLyUtGAPYeqw6NkvU/pE9tu?=
 =?us-ascii?Q?CftiVeVLEvTwx72cmL29c5GTJVZn20bwFC6vi4mB/6MMkR9iJODGgFqdoSHG?=
 =?us-ascii?Q?F+uG1ZvoIyKPpsIbYgw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b8afd0-eb52-477d-cf73-08db44de8eb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 16:11:27.0631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ii56jaEX/f4WNVYwA16F8nFp2++rw554obf5UzNoouVPUSkkmC3gQ+LOPQ4x8Rk3k4YBfjSOIvBcliyKibCYbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439
Subject: [virtio-dev] RE: [PATCH v14 03/11] content: Rename confusing queue_notify_data and
 vqn names



> From: Halil Pasic <pasic@linux.ibm.com>
> Sent: Friday, April 21, 2023 6:38 PM
> >
> >  \begin{description}
> > -\item [vqn] VQ number to be notified.
> > +\item [vq_index_config_data] Either virtqueue index or device
> > +supplied
>=20
> Apparently this our name for either index or notification config data, bu=
t I don't
> think we ever use it.
>=20
Right because this is generic description without the field data type and t=
heir endianness and transport specific information.
So, it uses an abstract term.

> I guess, there is a two to think about it:
> * Notifications are mostly transport specific. In particular what
>   data structures are used for the virtqueue notifications and how
>   they are passed, that is entirely transport specific. So the 'layout'
>   and the normative statements describing the details should be in the
>   transport sections.
Right. This addition did not add any normative. They are in transport secti=
on as you say.

> * The facility bits and the capabilities are basically common. I.e. if
>   MMIO or/and Channel I/O were to ever support VIRTIO_F_NOTIF_CONFIG
> data
>   (by providing means for transporting the virtqueue notification config
>   data from the device to the driver), what you call the notification
>   value would be either virtqueue index or this notification config data.
>=20
> You are taking the first approach here, and I'm fine with that. IMHO befo=
re we
> had the second approach implemented with vqn. I'm fine with taking the fi=
rst
> approach as well, but your commit message says "rename ambiguous vqn to a
> union of vq_index and vq_config_data" which for me implies you actually
> intended to take the second approach.
>=20
Those are renamed where the actual vqn is defined in the structure like bel=
ow.
In basic description section, it is just describing the functionality.

> > @@ -1,5 +1,5 @@
> >  le32 {
> > -	vqn : 16;
> > +	vq_index: 16; /* previously known as vqn */
> >  	next_off : 15;
> >  	next_wrap : 1;
> >  };
> > diff --git a/notifications-pci-le.c b/notifications-pci-le.c new file
> > mode 100644 index 0000000..ef60d15
> > --- /dev/null
> > +++ b/notifications-pci-le.c
> > @@ -0,0 +1,8 @@
> > +le32 {
> > +	union {
> > +		vq_index: 16; /* Used if VIRTIO_F_NOTIF_CONFIG_DATA not
> negotiated */
> > +		vq_notif_config_data: 16; /* Used if
> VIRTIO_F_NOTIF_CONFIG_DATA negotiated */
> > +	};
> > +	next_off : 15;
> > +	next_wrap : 1;
> > +};
> > diff --git a/transport-pci.tex b/transport-pci.tex index
> > 5d98467..04a9a80 100644
> > --- a/transport-pci.tex
> > +++ b/transport-pci.tex
> > @@ -319,7 +319,7 @@ \subsubsection{Common configuration structure
> layout}\label{sec:Virtio Transport
> >          le64 queue_desc;                /* read-write */
> >          le64 queue_driver;              /* read-write */
> >          le64 queue_device;              /* read-write */
> > -        le16 queue_notify_data;         /* read-only for driver */
> > +        le16 queue_notif_config_data;   /* read-only for driver */
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
> > +\item[\field{queue_notif_config_data}]
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
> > +        In a trivial case the device can set \field{queue_notif_config=
_data} to
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
> > +\field{queue_notify_off} or \field{queue_notif_config_data}.
> >
> >  If VIRTIO_F_RING_PACKED has been negotiated,  the driver MUST NOT
> > write the value 0 to \field{queue_size}.
> > @@ -1035,13 +1041,22 @@ \subsubsection{Available Buffer
> > Notifications}\label{sec:Virtio Transport Option
> >
> >  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,  the driver
> > sends an available buffer notification to the device by writing -the
> > 16-bit virtqueue index -of this virtqueue to the Queue Notify address.
> > +only the 16-bit notification value to the Queue Notify address of the
>=20
>=20
> You introduce the term notification value. Which basically means virtqueu=
e
> index or virtqueue notification config data.=20
Right and it is captured in the union fields.

> Which is basically what is defined
> where you define vq_index_config_data (the latter is never ever used agai=
n).
>=20
vq_index_config_data is abstract term without any bit fields, width, endine=
nss and without any attachment to transport details.

> > +virtqueue. A notification value depends on the negotiation of
> > +VIRTIO_F_NOTIF_CONFIG_DATA.
> >
> > -When VIRTIO_F_NOTIFICATION_DATA has been negotiated, -the driver
> > sends an available buffer notification to the device by writing -the
> > following 32-bit value to the Queue Notify address:
> > -\lstinputlisting{notifications-le.c}
> > +\item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver
> > +sends an
>=20
> The leading \item is probably not intended. Breaks the build and makes no
> sense.
Yes. it was not intended. Good catch.
Fixing in v15.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

