Return-Path: <virtio-dev-return-11859-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02C1C761A6
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 19:13:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 42B69370EE
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 19:13:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3711098658D
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 19:13:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2B57898654B; Thu, 30 Mar 2023 19:13:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 176F298654C;
	Thu, 30 Mar 2023 19:13:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ap0dEteuzX140icz7TRysKolNiDR4XyOp9BcD5dLBJFewXv3DKP+A2ROkBF9zQ2OgjZFec/tzxUeufqGxa76P0AfKO+Swu+3kQimRZSS3f0vNVI5NyYzmjDmJ51HQ1LDdQmJr31CDfBKF9G3sWwLBfImLrCAbaeEEFMLheVgbS1c6SfIp1SLvvg1W32vzUlbaYQvwZTBE09AFcBNsYVwHG+nKA9OEyxP1769DPRXJI8y6WYjokN57B7lYQztosc9WAkNbWH09RQvmGKaGqbXqEwm+U638i2Fqrs484Fr/nSOFHw8sUt8FD0/aqHG3KWF77PZYU5Var5R7Um3uHDTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmZ5OBDq/GkAmKFHUPxKhjhJRjLuXZEJEUYz4yuAkzQ=;
 b=SbnLWIgpI96x9fVpTeI18mDic3XnEkpafjZLs/7TfQwJcznHCmYs7daxR1nMGvDZcHBXi1e6Kjcf4Ukb8S81gor1vXAv7rMdTcRHWZb/FctmpmyVC2VGuENyROmi6xdJbW5z/1BX+6Su8SPKqUm6weyq46Gb/B7B8Ik+mH+F8/c0AoWxgdqJ8/fFBMcnnF6pXAqhLTcKai2644u1hwyh0PyGdYl4kT0yjtTQcVY0oIE2dEi/n4lizwaknTPdQYoy/tmjiX1ZbSOk05xwaLFMXK/qmZ+/QkPX4MRXCQpjGWBmnra3+3jDZ64QlrfUgV19mkXGK7fwnj0GPGAZiT4ARg==
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
Thread-Topic: [virtio-dev] [PATCH v10 0/8] Rename queue index to queue number
Thread-Index: AQHZYoTK+G4wjcUZS0KTWqxqTzIiaK8TkDoAgAAY0bA=
Date: Thu, 30 Mar 2023 19:13:47 +0000
Message-ID:
 <PH0PR12MB548165C4B11375F8C7EE7AD1DC8E9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230329212341.465843-1-parav@nvidia.com>
 <20230330191114.77acd860.pasic@linux.ibm.com>
In-Reply-To: <20230330191114.77acd860.pasic@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB6903:EE_
x-ms-office365-filtering-correlation-id: d772c05f-8d73-4654-4921-08db3152e356
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NE1ASSnOtGgmOgz33xz9FDOmM9P+dSRn5e7+KAAmsOvWXY9fJW+LtvT7vlz1lVmJ5VMgLWZCLL4BRK1TAIBUaFf+6QgKn7KpBsL/rxbuJ5+75U+O6pGgoGeQcv3hvbqjez0f0ILJNAtDPV6rOUYiIugkFTZd0dTTgXRXTTYuoI+CjM0Kd/NadxXg3Nc8aLbU8wWBuWNQ32Qov42tHmaZVzFkMVAXaTXWQTSFY4n0yJfQoqKePgA3HjSdeOdmqY9cOBLe2G+j3837VRq+B7kp/UfwOM7/CfwNjLV20bJu2QxPrHRIA8DMbOS4nW10yeX9BgbQseFAe/iz2vRMJ2svC6h6MRHg/7e6dnNsZMRcskIE2FDy7QydBox0Px0KKtvK7JZkRg94ACJvm+31NncBvJETGZjue02k1STJkdMK20zdOs3f/MkPJ2S5C4/Y/Ig5ZnxGiNCwZ2/eb0rVv0tkZLsiYQc8SGUa5Y5KosjIfWh5Xcwta8sqPiqwrBIcvdkUfwhwDIfJjQXwtUr5QqvgLjhKx1wlKRyRYIIT4QH7rzMdhUtnhwRrF2rWzzNIbpMkDcQSIQDjLDVhyauwGMr4VHQ4Qmz5ydK1kFMVfZZaxCTEUvuzpYJTHkTd37BiLw13
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(38070700005)(86362001)(9686003)(53546011)(83380400001)(33656002)(5660300002)(30864003)(186003)(6506007)(122000001)(52536014)(8936002)(2906002)(107886003)(7696005)(41300700001)(71200400001)(6916009)(55016003)(4326008)(54906003)(66946007)(38100700002)(66556008)(316002)(76116006)(478600001)(66446008)(8676002)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DArl5k7yudXNqvOsSirLNGLVRWToGeOBNbYkpW7wZB9E1Ur3H8yYmpg3Oo9X?=
 =?us-ascii?Q?HfjxW9BRJdW7UVUkmEypQnrZ7hepERI4Y/rc6kFUPZ7lZoSf5b+FQdmtWlE6?=
 =?us-ascii?Q?ieOKb7C3u8UXbzjS2/d2ABzeM250davIhCBfQxN0kuArOskMmb/LslfalMxG?=
 =?us-ascii?Q?Ua3EH8uQRlBIdxWh+da+3rYF78dpxldgmUkhtGQE0riGnCRsliKJy69lFSbg?=
 =?us-ascii?Q?JPb3uwdcExkAbtD6EeWiaoHz10fxKMEJfoieL4cVcbAelQ64qEOTZPl7QeoE?=
 =?us-ascii?Q?YRH7uBOJQbkaTFRV7y5cKInYRhJtQpimxbFHk/3jpiGtXXvYJjHp9eCIVFN0?=
 =?us-ascii?Q?rjVMShGSPA40w367bQjGs8WXVDk1R1Y9XxUsSt6z8/dNDwKtb1w4S1nS+K8M?=
 =?us-ascii?Q?a0ayxKAKTrX6rvdW8Wec4TXpVdHJxG0q9Y8kYBxZg8htdlRtSw+hvAPX/oUt?=
 =?us-ascii?Q?3wx1XVRSVZ2bcbPlGLBwzySCf0rrpz4XsnBIb1YOJJAVxCNHGaIUHXJN0vXi?=
 =?us-ascii?Q?Pf/H0UfY9QltkR1uGP4TgS7+AAjYVXCasT1KsZwJt8jSZgLG8wpZU5PjMwW/?=
 =?us-ascii?Q?7qje4v0sMtZXN8hbmMA8u0Hp2uwHwgE/wPWemhqymLe7KEGtsX0de5aB4l4F?=
 =?us-ascii?Q?y3mzWF7wIC+SPdjETNT17yUQksDc+u3qyowvLjLzqOM2wb+s2M0pNM3y7Evr?=
 =?us-ascii?Q?aOuMem2U1eNB7E2nVvof7e9m3a4j1npyB4AYlyvQNw+WtDjIcQdtpKV/olU8?=
 =?us-ascii?Q?XpJPxtMTsK/hQxqVrzTYwwtt8rQZAqKwpkYCVTG0+s90X8VoHAmlwP0HQftr?=
 =?us-ascii?Q?FCKuTgxXTdAQ0HB+m6ZMoiceDcGzNJmyYEsMCvk2J5iR/gyMGOkPQy8jXHVP?=
 =?us-ascii?Q?3/f5m3IxDHICemYIfdMW8cno70egCs3nNoQGFNdJEtMjOw8itZRaX/PRTUsP?=
 =?us-ascii?Q?ACiufrfucBFtLpKj3/uWC0tgZYrsGBMM6pBF/zUZxEBaQkfOHrV0MFWp/Eql?=
 =?us-ascii?Q?RN9j9o3Mz3e+bcDN6Mwg4Lo0iDn8sO8xWtsGtRE4/pcgvu071RHvS1Gc2CJ5?=
 =?us-ascii?Q?aDkBWD+wL4oUkxUVh2R0KRl3vd5KFzZ19zTXkt37qKJ1Gsvr2W6xSsnlWeho?=
 =?us-ascii?Q?t3Bj6c+Ref2jDHs+03tNfYemvodklczIW5zPmc1XR1cYhp0VKBZuVDKW5kyv?=
 =?us-ascii?Q?RO14mJx2I1pErUjTgA5ZmCsbCwudp+vxrxGYLukk0Az7JdUnRcHUeA2kywyE?=
 =?us-ascii?Q?LEkVM8D2/3lohu3nOF9bLQtbiQh/4ns6p2XHJxBYKTRHt2ZJT1h+vTXHowNJ?=
 =?us-ascii?Q?E+scUz7FByxGQr+kVz4I/aBe/Nv/ExiYRf/bya2giIWsHXTpO7gF2bDfPvf4?=
 =?us-ascii?Q?w6+xGpzZsy2Mdggz2OYQjsHnZJ5PDWw832luf30F1HWqwRKL5vcwhtWRG5wE?=
 =?us-ascii?Q?0O/XemCkWmWsDHmjOUn/TR1F+5Fi01Th+0nfC22S28F2EXni3cx/4+mDNih4?=
 =?us-ascii?Q?bAXcclxNSgD9irY8jS1uywPJVIQI24sQiwUBeEe5p0W/ua1Yi2VuTAvZA9gs?=
 =?us-ascii?Q?Po+WCp26XEGKyCsOKRQeB3k4feVl95HY/O1DCbp74OhCaepG+WCC+VZ5qX/3?=
 =?us-ascii?Q?YO80yrjRL4l7VHAyp/vUMog=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d772c05f-8d73-4654-4921-08db3152e356
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 19:13:47.3689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hrfvat4WbeRxbx3JWpvEIlP5QbE5FWH4OPf6RTGPMZ3A+o+S4KQCwnwq0tUCGJdZDomLjYUB5CQffl+jTlQ1og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903
Subject: RE: [virtio-dev] [PATCH v10 0/8] Rename queue index to queue number


> From: Halil Pasic <pasic@linux.ibm.com>
> Sent: Thursday, March 30, 2023 1:11 PM

> I argue that using a different term in that context than in the rest of t=
he
> specification makes sense, because in the context of notifications the vi=
rtqueue
> isn't always identified by its index.
Using single term as number is possible, so lets use single term.=20

>=20
> More precisely: if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated in the
> context of notifications the virtqueue is identified by the so called
> "queue_notify_data";=20
> if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated in

You missed "not" before negotiation. :)

> the context of notifications the virtqueue is identified by the virtqueue=
 index (as
> usual, for example in queue_select, or in the ccws).
>=20
> As I've pointed out in my comment to patch 2, I believe replacing virtque=
ue
> index with virtqueue number is detrimental to clarity.
>=20
> Thus please find a counter-proposal below. If there is interest I can mak=
e a
> series out of it, and prettify it. If I can't convince you guys, then I w=
ill have to
> get used to vqn and virtqueue number.
>=20
> AFAIR the other problem with index was the RSS for virtio-net. But there =
we are
> currently heading down a direction of introducing a new abstraction. This
> approach avoids confusion around the term 'virtqueue index' as much as it
> avoids confusion around the term 'virtqueue nuber'.
>=20
>=20
> > c. RSS area of virtio net has inherited some logic, describe it using
> > abstract rss_rq_id.
>=20
> -------------------------8<--------------------------------------
> From: Halil Pasic <pasic@linux.ibm.com>
> Date: Thu, 30 Mar 2023 17:57:53 +0200
> Subject: [PATCH 1/1] content: clarify how virtques are identified
>=20
> Clarify how virtqueues are identified in the context of available notific=
ations
> and in the context of RSS for virtio-net .
>=20
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  content.tex                      | 15 ++++++++++-----
>  device-types/net/description.tex | 30 ++++++++++++++++++++++--------
>  transport-ccw.tex                |  2 +-
>  transport-pci.tex                |  7 ++++---
>  4 files changed, 37 insertions(+), 17 deletions(-)
>=20
> diff --git a/content.tex b/content.tex
> index cff548a..a376232 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -298,6 +298,9 @@ \section{Virtqueues}\label{sec:Basic Facilities of a
> Virtio Device / Virtqueues}  virtqueues\footnote{For example, the simples=
t
> network device has one virtqueue for  transmit and one for receive.}.
>=20
> +If not otherwise stated, each virtqueue is identified by a so called
> +virtqueue index. Valid virtqueue indexes range from 0 up to 65535.
> +
Missing inclusive after 65535.
Covered in v10.

>  Driver makes requests available to device by adding  an available buffer=
 to the
> queue, i.e., adding a buffer  describing the request to a virtqueue, and
> optionally triggering @@ -402,7 +405,7 @@ \section{Driver Notifications}
> \label{sec:Basic Facilities of a Virtio Device /
>=20
>  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,  this
> notification involves sending the -virtqueue number to the device (method
> depending on the transport).
> +virtqueue index to the device (method depending on the transport).
>=20
>  However, some devices benefit from the ability to find out the  amount o=
f
> available data in the queue without accessing the virtqueue in memory:
> @@ -413,7 +416,9 @@ \section{Driver Notifications} \label{sec:Basic Facil=
ities
> of a Virtio Device /  the following information:
>=20
>  \begin{description}
> -\item [vqn] VQ number to be notified.
> +\item [vqn] Identifies the virtqueueue to be notified. If
> VIRTIO_F_NOTIF_CONFIG_DATA has been
> +      negotiateted, the value of \field{vqn} is the notify data suplied =
by the
> device
There is still vqn here.  So no better than vq number.
To be truly clear, it should be renamed to vq_identifier, that either conta=
ins vqn or vq_notification_data.

As I replied I can take up that cleanup at later point if we find some moti=
vation for CONFIG_DATA use.

> +      (by transport specific means). Otherwise it is the virtqueue index=
.
>  \item [next_off] Offset
>        within the ring where the next available ring entry
>        will be written.
> @@ -786,13 +791,13 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved
> Feature Bits}
>    buffer notifications.
>    As mentioned in section \ref{sec:Basic Facilities of a Virtio Device /=
 Driver
> notifications}, when the
>    driver is required to send an available buffer notification to the dev=
ice, it
> -  sends the virtqueue number to be notified. The method of delivering
> +  sends the virtqueue index of the virtqueue to be notified. The method
> + of delivering
>    notifications is transport specific.
>    With the PCI transport, the device can optionally provide a per-virtqu=
eue
> value
> -  for the driver to use in driver notifications, instead of the virtqueu=
e number.
> +  for the driver to use in driver notifications, instead of the virtqueu=
e index.
>    Some devices may benefit from this flexibility by providing, for examp=
le,
>    an internal virtqueue identifier, or an internal offset related to the
> -  virtqueue number.
> +  virtqueue index.
>=20
>    This feature indicates the availability of such value. The definition =
of the
>    data to be provided in driver notification and the delivery method is =
diff --git
> a/device-types/net/description.tex b/device-types/net/description.tex
> index d7c8b1b..7678a57 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -1421,18 +1421,33 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi
>=20
>  \subparagraph{Setting RSS parameters}\label{sec:Device Types / Network
> Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS=
) /
> Setting RSS parameters}
>=20
> +
>  Driver sends a VIRTIO_NET_CTRL_MQ_RSS_CONFIG command using the
> following format for \field{command-specific-data}:
>  \begin{lstlisting}
> +
> +struct rss_rq_id {
> +   le16 value; /* virtqueue index divided by two */ };
> +
This misses the freeing up the last bit of the value that Michael suggested=
.
Once that is done, it will start looking like v10.

>  struct virtio_net_rss_config {
>      le32 hash_types;
>      le16 indirection_table_mask;
> -    le16 unclassified_queue;
> -    le16 indirection_table[indirection_table_length];
> +    struct rss_rq_id unclassified_queue;
> +    struct rss_rq_id indirection_table[indirection_table_length];
>      le16 max_tx_vq;
>      u8 hash_key_length;
>      u8 hash_key_data[hash_key_length];
>  };
>  \end{lstlisting}
> +
> +The type struct rss\_rq\_id is introduced to better distinguish receive
> +queue ids form other integral fields.
> +
> +A receive queue id is only defined for receive queues, as the virtqueue
> +index of the receive virtqueue divided by two (the virtqueue index of a
> +receive queue is always even). For example receiveq4 is identified by
> +the virtqueue index 6 and the receive queue id 3.
> +
>  Field \field{hash_types} contains a bitmask of allowed hash types as  de=
fined in
> \ref{sec:Device Types / Network Device / Device Operation / Processing of
> Incoming Packets / Hash calculation for incoming packets / Supported/enab=
led
> hash types}.
> @@ -1442,10 +1457,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device
> Types / Network Device / Devi  \field{indirection_table} array.
>  Number of entries in \field{indirection_table} is
> (\field{indirection_table_mask} + 1).
>=20
> -Field \field{unclassified_queue} contains the 0-based index of -the rece=
ive
> virtqueue to place unclassified packets in. Index 0 corresponds to receiv=
eq1.
> +Field \field{unclassified_queue} contains the receive queue id of the re=
ceive
> virtqueue to place unclassified packets in.
>=20
> -Field \field{indirection_table} contains an array of 0-based indices of =
receive
> virtqueues. Index 0 corresponds to receiveq1.
> +Field \field{indirection_table} contains an array of 0-based indices of =
receive
> queue ids.
>=20
>  A driver sets \field{max_tx_vq} to inform a device how many transmit
> virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
>=20
> @@ -1455,7 +1469,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device
> Types / Network Device / Devi
>=20
>  A driver MUST NOT send the VIRTIO_NET_CTRL_MQ_RSS_CONFIG command
> if the feature VIRTIO_NET_F_RSS has not been negotiated.
>=20
> -A driver MUST fill the \field{indirection_table} array only with indices=
 of
> enabled queues. Index 0 corresponds to receiveq1.
> +A driver MUST fill the \field{indirection_table} array only with receive=
 queue
> ids of enabled queues.
>=20
>  The number of entries in \field{indirection_table}
> (\field{indirection_table_mask} + 1) MUST be a power of two.
>=20
> @@ -1467,8 +1481,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device
> Types / Network Device / Devi  The device MUST determine the destination
> queue for a network packet as follows:
>  \begin{itemize}
>  \item Calculate the hash of the packet as defined in \ref{sec:Device Typ=
es /
> Network Device / Device Operation / Processing of Incoming Packets / Hash
> calculation for incoming packets}.
> -\item If the device did not calculate the hash for the specific packet, =
the device
> directs the packet to the receiveq specified by \field{unclassified_queue=
} of
> virtio_net_rss_config structure (value of 0 corresponds to receiveq1).
> -\item Apply \field{indirection_table_mask} to the calculated hash and us=
e the
> result as the index in the indirection table to get 0-based number of des=
tination
> receiveq (value of 0 corresponds to receiveq1).
> +\item If the device did not calculate the hash for the specific packet, =
the
> device directs the packet to the receiveq specified by \field{unclassifie=
d_queue}
> of virtio_net_rss_config structure.
> +\item Apply \field{indirection_table_mask} to the calculated hash and us=
e the
> result as the index in the indirection table to receive queue id of the d=
estination
> receiveq.
>  \item If the destination receive queue is being reset (See \ref{sec:Basi=
c
> Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the devic=
e MUST
> drop the packet.
>  \end{itemize}
>=20
> diff --git a/transport-ccw.tex b/transport-ccw.tex index c492cb9..bc05639
> 100644
> --- a/transport-ccw.tex
> +++ b/transport-ccw.tex
> @@ -544,7 +544,7 @@ \subsubsection{Guest->Host
> Notification}\label{sec:Virtio Transport Options / Vi  \end{tabular}
>=20
>  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated, -the
> \field{Notification data} contains the Virtqueue number.
> +the \field{Notification data} contains the virtque index.
>=20
>  When VIRTIO_F_NOTIFICATION_DATA has been negotiated,  the value has the
> following format:
> diff --git a/transport-pci.tex b/transport-pci.tex index b07a822..9b71c05=
 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -390,15 +390,16 @@ \subsubsection{Common configuration structure
> layout}\label{sec:Virtio Transport
>=20
>  \item[\field{queue_notify_data}]
>          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been
> negotiated.
> -        The driver will use this value to put it in the 'virtqueue numbe=
r' field
> +        The driver will use this value to put it in the \field{vqn}
> + field
>          in the available buffer notification structure.
>          See section \ref{sec:Virtio Transport Options / Virtio Over PCI =
Bus / PCI-
> specific Initialization And Device Operation / Available Buffer Notificat=
ions}.
>          \begin{note}
>          This field provides the device with flexibility to determine how=
 virtqueues
>          will be referred to in available buffer notifications.
> -        In a trivial case the device can set \field{queue_notify_data}=
=3Dvqn. Some
> devices
> +        In a trivial case the device can set \field{queue_notify_data} t=
o the
> virtqueue index,
> +        that is the value in \field{queue\_select}. Some devices
>          may benefit from providing another value, for example an interna=
l
> virtqueue
> -        identifier, or an internal offset related to the virtqueue numbe=
r.
> +        identifier, or an internal offset related to the virtqueue index=
.
>          \end{note}
>=20
>  \item[\field{queue_reset}]
> --
> 2.31.1
>=20
>=20
Most field changes are using index instead of number here in one patch.
No different than "number" patch.

And it still uses the vqn field name in the notification.
vqn is at least correct field name when CONFIG_DATA is not negotiated.
With 'index' usage, vqn field name is incorrect regardless of CONFIG_DATA, =
because its intents to hold index or something else. :)

So v10 has same or higher score as index.

Given everyone have come this far and also other patches using vqn, I think=
 we should proceed to use "number".

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

