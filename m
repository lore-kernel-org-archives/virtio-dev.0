Return-Path: <virtio-dev-return-11378-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E500DC6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 14:48:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2FE4A65F
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 14:48:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 294B59866D5
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 14:48:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 18B18986672; Thu,  2 Mar 2023 14:48:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0583E986674;
	Thu,  2 Mar 2023 14:48:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzvYxObn9wvugu48fuIR9CoBj8DZ6beD0hn7FB6NuBV4tPWiZLaGebJsv+VloX+M4ZW3PBYiK6jDEZHyUCeqbCIN6aH3AqJMCM0rHB2mtt78mPiBEZeW2V6tk8mZtgQAwPhIb4+N0dlY4cLI3pqHGsPLSX0UbNobZ7vl14mdDPGHN0RHXhWxXVGBIq6wkbXwkrLMqrjPSI2Fqyz+lDEG121hGwg8n7kdDLSKtZpqLOjbnpjrTjuPsVvOvsmQv7verOcdgBTozh0alrnlit+NjI3BbbZxjYP/2m67HvhKrdZm7ol/mf0dd7OyvHuFA08sI/kBe6tlw5E4n2BXu+S9dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjYi0QFDpONkMmbHaLfpUZ0/b7nB05Qjt8XXyybwiH4=;
 b=Z9CN3WcQxY6qR2YSpQ7iuuPMAWav/hyx2WBX4n6kqqNDyJNzNeuwf5DRmjhqv1uV+34ADmgXmKek0YAlPgFMb2joMx/N9RJ7Iw1txG23YaD9LUYZpcjN0iWW/Ysj9TP4+TqFxFu15Kpgs2dzPvzOFxVnr5vBmCwgfdebjyXpz8FXPpekDXBWcYcatH7bqOOiO51lpjYG3vLJWWaoXCdCL72XT/Y6AySIpWrh9cDGdYpeMR41dND42aWi+wicQB8DQ3MB7Bc5CckPTO1DWGHaUerqtYWxfBnACU3v76HgIryfq4cobGcWvPgKvlLqdslWCldUtTr8SMDlinb6Nu/GCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Alvaro Karsz
	<alvaro.karsz@solid-run.com>, David Edmondson <david.edmondson@oracle.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
Thread-Topic: [PATCH v10] virtio-net: support the virtqueue coalescing
 moderation
Thread-Index: AQHZTEeWQwTFVtCRMEet8OSrJT5oDa7niZXw
Date: Thu, 2 Mar 2023 14:48:44 +0000
Message-ID:
 <PH0PR12MB548192A8443A7F30A70CFE80DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230301141027.59500-1-hengqi@linux.alibaba.com>
In-Reply-To: <20230301141027.59500-1-hengqi@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB7504:EE_
x-ms-office365-filtering-correlation-id: 59c9ffbb-14bc-4340-f817-08db1b2d38c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ycgSxnFFFVzZ/QxieJZNQiUnUMxWB2WoL195GGfjQrPfGPdm1C9jQVHWG4jwQPFGaUVyGqPt0nJcBCAtxEmekJaS+mzWNNZLCAy+igAxQTS/Eyop/KhqEyWKCVNle0oyM8+miykN5NR6QuW4vfo4SVfhXmDwny7myz+2jMtB4OjzQzfSS6N8X4AUWd5YQSr9AAucmf2AVjWnFxs6PqfS2ECCugA8ZW5ohjWMGpgyKvRd8OMb03pbsirhEwvShFifH/6cxotnruI/pAWLj+OMJxORbQpH5gLjgzXN053m4ZA47XcPXM1OdO2UbQojhx+EkoKywt/uAmL1zX0tkUyvWEPIZdqtc2POn7xDbEsFWmy8PTtDA1OqvGERIcPlvTH96t0XaWUR6iC9ojiFkcUMgfv4cqPGa38ergS0IAfc6FO+aVWlz6vN3eaHvMFORKD3EhmEGjGoCEc8zpuUyFPEGY4cCUVFX9gUZnCncjTjL6E8qD18/vJB57jryeA5q1fMs0do1LnBPfKpjF4hm7mpg0mWQ4XnarYIslsT5gA6s89HcoFhOGxC9B2gE7CwJqeDBHgYgC/q9hTqfSE3erZr4VhG14FTgxMVZKkikZGT6AgUXXDERtJXbU0PM6XvCEDLvGeoTogNvFPElZPP+76DSRKZOJtTOWedZchCpekV772Rr2p3KGwmT4sbmtDUpOxVFRsqfcxUnrFldwZbzDuPGA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199018)(71200400001)(26005)(9686003)(186003)(54906003)(110136005)(316002)(41300700001)(64756008)(66446008)(66476007)(8676002)(76116006)(66946007)(6506007)(4326008)(7696005)(2906002)(52536014)(5660300002)(478600001)(8936002)(38100700002)(122000001)(86362001)(33656002)(38070700005)(55016003)(66556008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oj3yZ/51j9BXripYAsYfCsqbCubTRdmiFgU0r5W0lEUO444ZXkE1Vwt4RFmz?=
 =?us-ascii?Q?5PvXFomTo7wmGe3HYc8toGIeC3+xk9ZPEecqwTweFsFSNI8HLsJakVSarWPN?=
 =?us-ascii?Q?SfO0ZnuJgSx6W9OQolqH80tp6aFFuSc8SU1bFNyPfX5Lad/CGkWY7vs1fgf9?=
 =?us-ascii?Q?R9Z12GJZCeTPRUS4oUoIj9OXDEZgqjOVi+gP9XtqcmFL2lG2qocV0Kz2bkR8?=
 =?us-ascii?Q?PZy/cY8J+EBdSfFa9Yj7iMbxTbRbbtubYjehmRNJFmyqTm23mb/UwRE9b0gA?=
 =?us-ascii?Q?fZahdwNIkyqper1Tdb3zsFn4+nIXKmH8MU5IAq1NadmLdObYkoYyZBH55WWg?=
 =?us-ascii?Q?H1eyniisU0jDodZ/srXyYZKptsNhblgGd60mb4fDegyGo2o29vHj4JxyLE39?=
 =?us-ascii?Q?52zlIe32uSDK51X724cCyPV9doGvgwyjWSnyk9kBvrVVz+O/0sMgUGWXp54Y?=
 =?us-ascii?Q?u1hSSVTEl9C5JAvOROvCxTfZzpEn7SXZF5O/I35Wo0JBR7WCV315u5KfHjAG?=
 =?us-ascii?Q?OVx7qK8Z9uoHrkhPEnFGRXEm9UB4bKpGBp96GFXNwaQ2+jpjLPd1KmBH2p4O?=
 =?us-ascii?Q?bWAwQOgr/DIE3QKL3gIL3COt6e7W9f3JlgAQqBZigNsYGqouslod3W76uJ5I?=
 =?us-ascii?Q?PpFgYSFovq0YUkMZK8evEH/M2ul7E6pv2ZvWA8RGYHMmxPGEL4dyTIYG3eib?=
 =?us-ascii?Q?T/aRF4VLE3GU69k2GI6k57uLr744z2O8ddaa4CG+zI8gxVuckRKUT3lQxCPZ?=
 =?us-ascii?Q?x3MCfv4D450u/1bAbrRMcDejncsa/P5fNSslvPYL1pl6Y/bRxQYVZzZvqV4x?=
 =?us-ascii?Q?McLbBo6Bdy1i6+5qH/0O7zb3nD3SoWzH9bCz+4DfqSLKXD+RT47KHuWpqUuu?=
 =?us-ascii?Q?D7hGRs7KmgfeJRRoTB/d8AZ7bPGXfVV1J7yRaWLCl1eZH/3K1IMi6dD9Zi7u?=
 =?us-ascii?Q?3KHawKOOpfqAg7R3rf7OmdBNYp4/vjbP5qC4fnuqBv8Db1Gnnjzx1a7qedAC?=
 =?us-ascii?Q?SulDulrruET9SZd5kwQpx2+XVNfvnEnAoRIijMgurAhnxyfv1nkxdWK/WT7h?=
 =?us-ascii?Q?vbJ3FW6L3EEseMJAwsqrayb3BlvtBsDDWlHcFyosGEPFu6xmMlO3DhiIOZC7?=
 =?us-ascii?Q?1ntSPFoNXaa3A0Dgypawjmd2EWuG2AA/vmoyXhrq8ZsvjcsrYggnCmTVE3zN?=
 =?us-ascii?Q?8x2whqN//6++/PPTHm2MmNQNHvtvy3jju5GwtyrcJc2PXmad90273UE4A4iS?=
 =?us-ascii?Q?COrBn+TBQ0rk8xOZdU2DL1RRs/kSaYPi36hdFf+t/1tLEz/m2Z3oCGZIACh4?=
 =?us-ascii?Q?8q5d0g30zUE+LRVtR+OzXW1tTURXktMqahFWq08hNirPA1Y7h5+JDJ9B0f0u?=
 =?us-ascii?Q?KAqYPJUmGzEEf7UUhjJhqvZ8Sgzbc3JknNdRjiFhlSbkU5mHVVshJJiAxlta?=
 =?us-ascii?Q?NI0mTtJfiTNwRrFaJrPz8Zf+zQjsLueiby0RUSkQvLd0E6fyf4KKBU9fImGx?=
 =?us-ascii?Q?mGmy0rsa3r1tS0r4gXJ6nh0UAUDdOxBnChHh6Gh4UutqO69/Te/D1gc3F76z?=
 =?us-ascii?Q?ngroFFRtuABtTboHlM8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c9ffbb-14bc-4340-f817-08db1b2d38c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 14:48:44.2590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zIAayepFXg0S+Mhls6IZlYt2fjtYwR0IGclCli1Nd821UfEWpRZHtVcyvw5C6UxAggmGZdL0c7C5rXvt6jCqrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7504
Subject: [virtio-dev] RE: [PATCH v10] virtio-net: support the virtqueue coalescing
 moderation



> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Wednesday, March 1, 2023 9:10 AM

> Currently, coalescing parameters are grouped for all transmit and receive
> virtqueues. This patch supports setting or getting the parameters for a s=
pecified
> virtqueue, and a typical application of this function is netdim[1].
>=20
> When the traffic between virtqueues is unbalanced, for example, one
> virtqueue is busy and another virtqueue is idle, then it will be very use=
ful to
> control coalescing parameters at the virtqueue granularity.
>=20

[..]
> +Read/Write attributes for coalescing parameters:
> +\begin{itemize}
> +\item For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET, \field{max_usecs}
> +      and \field{max_packets} are write-only for a driver.
> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET, \field{vqn},
> \field{reserved}, \field{max_usecs}
> +      and \field{max_packets} are write-only for a driver.
> +\item For the command VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET, \field{vqn}
> and \field{reserved} are write-only
> +      for a driver, and, \field{max_usecs} and \field{max_packets} are r=
ead-only
> for the driver.
> +\end{itemize}
> +
Maybe I missed the conversation while I was sick.
I remember we discussed that instead of mentioning each individual field, b=
etter to describe the whole structure being read-only or write-only.

> +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
>  \begin{enumerate}
> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and
> \field{max_packets} parameters for all transmit virtqueues.
> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and
> \field{max_packets} parameters for all receive virtqueues.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: use the structure
> virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets}
> parameters for all transmit virtqueues.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: use the structure
> virtio_net_ctrl_coal to set the \field{max_usecs} and \field{max_packets}
> parameters for all receive virtqueues.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: use the structure
> virtio_net_ctrl_coal_vq to set the \field{max_usecs} and \field{max_packe=
ts}
> parameters
> +                                        for an enabled transmit/receive =
virtqueue whose
> number is \field{vqn}.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: use the structure
> virtio_net_ctrl_coal_vq to get the \field{max_usecs} and \field{max_packe=
ts}
> parameters
> +                                        for an enabled transmit/receive =
virtqueue whose
> number is \field{vqn}.
>  \end{enumerate}
>=20
> +\begin{note}
> +The behavior of the device in response to these commands is best-effort:
> +the device may generate notifications more or less frequently than speci=
fied.
> +\end{note}
> +
Michael,
Why this should be a note? Shouldn't it be a normative line in the device r=
equirements?

> +If coalescing parameters are being set, the device applies the last
> +coalescing parameters received for a virtqueue, regardless of the
s/received/set to match the if condition wording and regardless sentence af=
ter.

> +command used to set the parameters. Use the following command sequence
> with 2 pairs of virtqueues as an example:
> +Each of the following commands sets \field{max_usecs} and
> \field{max_packets} parameters for virtqueues.
> +\begin{itemize}
> +\item Command1: VIRTIO_NET_CTRL_NOTF_COAL_RX_SET sets coalescing
> parameters for virtqueue0 and virtqueue2, and, virtqueue1 and virtqueue3
> retain their previous parameter values.
> +\item Command2: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =3D
> 0 sets coalescing parameters for virtqueue0, and virtqueue2 retains the v=
alues
> from command1.
> +\item Command3: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} =3D
> 0, the device responds with coalescing parameters of virtqueue0 set by
> command2.
> +\item Command4: VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET with \field{vqn} =3D
> 1 sets coalescing parameters for virtqueue1, and virtqueue3 retains its p=
revious
> values.
> +\item Command5: VIRTIO_NET_CTRL_NOTF_COAL_TX_SET sets coalescing
> parameters for virtqueue1 and virtqueue3, and overrides the values set by
> command4.
> +\item Command6: VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET with \field{vqn} =3D
> 1, the device responds with coalescing parameters of virtqueue1 set by
> command5.
> +\end{itemize}
> +
> +Upon disabling and re-enabling the transmit virtqueue, the device will
> +set the coalescing parameters of the virtqueue to those configured throu=
gh
> the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or to 0 if the command
> did not set any TX coalescing parameters.
> +
> +Upon disabling and re-enabling the receive virtqueue, the device will
> +set the coalescing parameters of the virtqueue to those configured throu=
gh
> the VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or to 0 if the command
> did not set any RX coalescing parameters.
> +
Looks good, however you have well covered in the device normative statement=
s.
So possibly it can be removed from here.

>  \subparagraph{Operation}\label{sec:Device Types / Network Device / Devic=
e
> Operation / Control Virtqueue / Notifications Coalescing / Operation}
>=20
>  The device sends a used buffer notification once the notification condit=
ions are
> met and if the notifications are not suppressed as explained in \ref{sec:=
Basic
> Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Sup=
pression}.
> @@ -1585,11 +1637,25 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi
>=20
>  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types /
> Network Device / Device Operation / Control Virtqueue / Notifications
> Coalescing}
>=20
> -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the drive=
r
> MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> +A driver MUST negotiate the VIRTIO_NET_F_NOTF_COAL feature before
> issuing commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> VIRIO_NET_CTRL_NOTF_COAL_RX_SET.
> +
> +A driver MUST negotiate the VIRTIO_NET_F_VQ_NOTF_COAL feature before
> issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and
> VIRIO_NET_CTRL_NOTF_COAL_VQ_GET.
> +
> +A driver MUST ignore the values of coalescing parameters received from t=
he
> VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET command if a device responds with
> VIRTIO_NET_ERR.
>=20
>  \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types /
> Network Device / Device Operation / Control Virtqueue / Notifications
> Coalescing}
>=20
> -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands
> with VIRTIO_NET_ERR if it was not able to change the parameters.
> +A device MUST ignore \field{reserved}.
> +
> +A device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it
> was not able to change the parameters.
> +
> +A device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> command with VIRTIO_NET_ERR if it was not able to change the parameters.
> +
> +A device MUST respond to VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET and
> VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET commands with VIRTIO_NET_ERR if
> the given virtqueue is disabled.
> +
> +After disabling and re-enabling a transmit/receive virtqueue, the
> +device MUST set coalescing parameters of the virtqueue to those
> +configured using the
> VIRTIO_NET_CTRL_NOTF_COAL_TX_SET/VIRTIO_NET_CTRL_NOTF_COAL_RX_S
> ET command, or, if the command did not configure TX/RX coalescing
> parameters, to 0.
>=20
>  A device SHOULD NOT send used buffer notifications to the driver if the
> notifications are suppressed, even if the notification conditions are met=
.
>=20
> --
> 2.19.1.6.gb485710b

Rest looks good to me.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

