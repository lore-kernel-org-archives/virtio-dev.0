Return-Path: <virtio-dev-return-11325-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0949C64ED6
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 01:40:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DB1F929FC1
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 01:40:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C593F986627
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 01:40:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B94B8986602; Tue, 28 Feb 2023 01:40:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A145A9865FA;
	Tue, 28 Feb 2023 01:40:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AW3vtRPX7mxvidQlWZIABplqlhTBLWt3OIavNAhBA+7Vy+7kTZDLJ9FcsRjT+63pMF2CDphsdPoQrk+ckoL7EfFKJRFxFdO4vB7seL1KR+CDcTARFPhPnNAD921BlS/pZAngAr7B5NRD0bt7YwAqNG+Mzv8sw3YPqNU1qf6RBcLsYKe9HgYBgyxQV5cY9+LSKF2TtTehPqhTgE0JBcyg6MG6UqNkkcQjXq/OWVk8BNH/ZS/J1tkzi+eKPLYYW8dSF6tDR/a8ysjOYccMYbPXW9C3rVxBUqsl9PBHlveMF+xGvz3qi+qvfaJb2whVEtodSKQGdHYqnerAbUkfFjhK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8c2vI5F4T5/2FlJ+LtmJ+IP6/wgw/AFMyVNliyQeoqk=;
 b=RPFJQFpyQJ4sdNL+RTZ+9yvbWZ3u7kG1ac+A6YQhviVuRqo029Ovq48Tn62pVSTHGA6Ekytxt7CgTd//Ddd7wmMGngBKSoPIVnimgFjnntItSzjhaGBufmIEqWRzT4MpT9tnabaT07na74CUTGeeWtipZ4aamHtA/YdP9gbhUaxAnqdiaKg5B+JKZ0COfZBsTDT37tFltCl/5F9vzcnnISqRExtkCUFjVMTUIMIEhrmjk9GJlgwTcziMz1iPJrh7BBq37VJQWV9fs3JKr6vWH53hZ/HsSTm5CzWNJDlYaWxgQZG+iRsZtxvmmzL+wD0CguytP9Xgj2POaN5W7Wrapg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>
CC: Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, David Edmondson <david.edmondson@oracle.com>, Jason Wang
	<jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [PATCH v9] virtio-net: support the virtqueue coalescing
 moderation
Thread-Index: AQHZScXyLv/WnfWq8UO7YKmjB55KUK7jj2VQ
Date: Tue, 28 Feb 2023 01:40:29 +0000
Message-ID: <PH0PR12MB548149DF3FCB29805E442F75DCAC9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230226093724.44717-1-hengqi@linux.alibaba.com>
In-Reply-To: <20230226093724.44717-1-hengqi@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB7593:EE_
x-ms-office365-filtering-correlation-id: eb30bf3c-ac2b-4f44-f01f-08db192cc603
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8XGYcPZOB4d1zgBM0TWzLvOLfzE4Sj21oGl7lF4NmZpxABJYs+RWoIryI/t2JlgLKgrOUpT+t++ETpoo9B6vrhH9x1AnPWstVTIgudgyZ6XPm4/fFI3AuONTWJnzHnbFHO8kSP5c65xG+1GOOPOOFBG5r8f5v7+vQYz+P68U109bVD9YYbbNpiquadfbHT/WMcx1TS28XgtCm8Ig5+AfHLUeWDgPn4f75QxEJErWz0ZNW9AQ2Q1GrEykwD69DowRv6i6EpHPPRRgE5wndKsTgiSnI1Gl40yGcqhbxw/qs7WRdsbeHzmvhFDKHIkJqnFfudO0M+Z33/CEhpt17OH54sLYkNp5WzmJIyRsc1VZ9x/r5n2eNUugPtzyYcugF5SuL+9qSWFiebXHOBUFwJEMrhvB0g/MPDVyXX3bpHozdWp7kB1EpDshU5ItsZWMSJ7jk5Is6Hd+t9O/4//aW8Q6zUJ7PV29sPNqWNLHbACdMLFy8Q6b8LS0M69/KPMizhEmS3DmcQ209sfvdmEqmacrjfofsNHqCZJqio5do/6OBZi5X4+uRagqvoSaru/5iP7ko85/gwJ0er0zpi+4vzo6kf9E14El4QQZF+YdRy2l5VHb/G2Vnht32uWuzjmIAF1xMY03BeeEoI/VqVRJ1eMy43wyeVoy8C3Xg5GHsaXSs5+3Am4WsACB/AfI6Vvi2yfh2Si89a90Aq5XUgr90kA/3w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199018)(186003)(9686003)(7696005)(33656002)(8936002)(38100700002)(41300700001)(55016003)(38070700005)(478600001)(8676002)(64756008)(71200400001)(76116006)(66476007)(66946007)(66446008)(4326008)(66556008)(6506007)(5660300002)(86362001)(122000001)(52536014)(54906003)(2906002)(110136005)(83380400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?X5XP2G3IveEQQYcQLq1/4pZt6orVyPbsMf9VOGRzIip2LEP6+Ow7SmHqr3Oq?=
 =?us-ascii?Q?F3AW5KgqFYSTyfhyxMrUVEt91pm/Roy8XmlgYQkgc/W1z3CsvUVwcJyMEa0e?=
 =?us-ascii?Q?i9T4LEa6du/f8QoeTYbT/mhUoX0RsEbDGhTB9wDZ0j9ek9TYaNkuByTz2kol?=
 =?us-ascii?Q?u3Oxu45ILrlqwhWH6kpjWrukQeNrbu79Q7nN47TnmAYHoIFAAJsfs4jltU2x?=
 =?us-ascii?Q?vlnrMujgn1t7bKAI/zIO2MxCB8H9NmZhP7rJlSZ+aUwVKM0UnALgLdlOrl4C?=
 =?us-ascii?Q?Ptpt3nl+JtDEYq0rrfTdRtMoiXoDMfEklE7GYHMFNvj8aPssGtxXSoAFy0GR?=
 =?us-ascii?Q?MzNstEW4/27AjOjhiCL8x0v9WGirC74SCqyky9h+rq1z0nGof1PQVho4YTsl?=
 =?us-ascii?Q?PkZmwcH/erClX/SpYZjzeKJcS8V8JUivsQGCxCuyIHpmlw66n0ZQTPv4jhKb?=
 =?us-ascii?Q?hCmJC265Q4UQCWBZXYGCZSwmHqgRm4DDpzJYxRioisRmqdGVQG1lkyReD1Bs?=
 =?us-ascii?Q?98j1ojGHOnTz7rs2wqXjcFwdFaavBwgB7pftvZ5CXoyhWrfBDDmJjqiebxLr?=
 =?us-ascii?Q?HE6es8lbzKJ4WHq1N3CIuY/VyCD49QZsZxu8UdSvbxK0LZXOAZdRyNAvgW3C?=
 =?us-ascii?Q?VjD/m+HTsi8WTqd6KX1uJAIQRdSYDGQwQs1OUKzkdiP8S5dlT22TRmpLGHpS?=
 =?us-ascii?Q?GqcgohMnA51KymP1xCspZuEgR/Wb1Hmsnr0ss+0oe8HibUwlyGm1bPzm48N6?=
 =?us-ascii?Q?fhRcSlAs8kChSvWd35GiddJy3P05GCzos/dhfmF7ZgRofm+jj+EnQqzgTYr4?=
 =?us-ascii?Q?leEE9CjiC0WpWkg9ggYovuMzkV9rEO5OSLFwB28FAZwLYyDV3/0WlWLIBh2w?=
 =?us-ascii?Q?RJ0COQN6ZVVbAWmLveESCyomnnOs+m934Is37JpaH18OkfqdxNt5reuFoSMi?=
 =?us-ascii?Q?N4G7AfBJ1v0PZ+TgNNDRbbGbCRlR0vqGrD1XryvamYrt+MgSLbY5jsq1dlwA?=
 =?us-ascii?Q?A9jHkAD6iLRTZYxZuh3scUXdgNnDrk610JwDW6jF7NmBYNFucwo2Z0avCRjC?=
 =?us-ascii?Q?o/fFUH40PLY0ZENukqyki1lU/QOoqd5HEldP808XP6+P2yC8qZiNK6+YTuAx?=
 =?us-ascii?Q?69cG9+tlu9iQ2K7CaxVTxiHbwMnP4UktbLBxXI3WEj5eRpzlkBUdkkZP0bJl?=
 =?us-ascii?Q?3y9EeHIsSYjGCsfMgwLGSKe3FlAVjyo/QXmDqI0QC1/CMDFXBbe7QNs0emFg?=
 =?us-ascii?Q?rYLyJpMiQx9fC6d9OTFx+atNvkqQZoXYcye2sKoDWNfJO+morJ8XD5h5oL4Q?=
 =?us-ascii?Q?nV+wYdkoyTTTn4f1hg60jJpCesnUgRwDiBTszjOVwUSNgaAjWg2LlSmVYSCr?=
 =?us-ascii?Q?hKWNdYWXKwpqNky1TPBB/AyqdA9MaNAcsZ+N0o6KbRFexztAnKtaq33+z0vN?=
 =?us-ascii?Q?d9DBWIGjEher1v/Dh5/tH/zEPdtw6hYGItdGnvqeaqKWija65yyeHN8oXmNY?=
 =?us-ascii?Q?GC2M/vAFbWnoRn+TGHqg5GYK70kcUm9av3NJC38XT3NijqGwP6nS0RBgfj2f?=
 =?us-ascii?Q?ly1Zb9xplty1xIOsb9/ccGV822qKB4PkqIsrXO008+toLdlTA/f1uopLqz4h?=
 =?us-ascii?Q?Nk7Bulg12v5Y552w8BVkSxw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb30bf3c-ac2b-4f44-f01f-08db192cc603
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 01:40:29.3834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3M6BmHnP8M77l4fH8EDC8DrZVVlYnnzK9ES1FTSL8W/c9K7/wsRiBFeMBu85RVUGibQcCkrC6p3Q5wKWyK/zNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593
Subject: [virtio-dev] RE: [PATCH v9] virtio-net: support the virtqueue coalescing
 moderation
Message-ID: <20230228014029.zkSCsAWhZcrcdQepycvzGxgculKsCBVSKr4d-zVpWXM@z>


> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Sunday, February 26, 2023 4:37 AM

> +# Read/Write attributes for coalescing parameters \begin{itemize} \item
Hash # above is not needed. Please remove.

> +For commands VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
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
Instead of describing each individual fields of the structure struct virtio=
_net_ctrl_coal coal as read-only or write-only, better to say the struct it=
self as read/write only.
This way when/if in the future, if struct virtio_net_ctrl_coal coal extends=
, no need to rewrite this section of the spec.

> +
>  Coalescing parameters:
>  \begin{itemize}
> +\item \field{vqn}: The virtqueue number of an enabled transmit or receiv=
e
> virtqueue.
>  \item \field{max_usecs} for RX: Maximum number of microseconds to delay =
a
> RX notification.
>  \item \field{max_usecs} for TX: Maximum number of microseconds to delay =
a
> TX notification.
>  \item \field{max_packets} for RX: Maximum number of packets to receive
> before a RX notification.
>  \item \field{max_packets} for TX: Maximum number of packets to send befo=
re
> a TX notification.
>  \end{itemize}
>=20
> -The class VIRTIO_NET_CTRL_NOTF_COAL has 2 commands:
> +\field{reserved} is reserved and it is ignored by a device.
> +
> +The class VIRTIO_NET_CTRL_NOTF_COAL has 4 commands:
>  \begin{enumerate}
> -\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and
> \field{max_packets} parameters for all transmit virtqueues.
> -\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and
> \field{max_packets} parameters for all receive virtqueues.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_TX_SET: set the \field{max_usecs} and
> \field{max_packets} parameters for all transmit virtqueues, and values of
> +                                        coalescing parameters are record=
ed as TX global values
> by a device.
"recording TX global values" is not conveying anything more as "all transmi=
t virtqueues" is already mentioned.
The original text without "recorded as Tx global values" is just fine. Same=
 for the RX below.

> +\item VIRTIO_NET_CTRL_NOTF_COAL_RX_SET: set the \field{max_usecs} and
> \field{max_packets} parameters for all receive virtqueues, and values of
> +                                        coalescing parameters are record=
ed as RX global values
> by a device.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET: set the \field{max_usecs} and
> \field{max_packets} parameters for an enabled transmit/receive
> +                                        virtqueue whose number is \field=
{vqn}, and do not
> change the TX/RX global values.
> +\item VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET: the device returns the
> \field{max_usecs} and \field{max_packets} parameters for an enabled
> +                                        transmit/receive virtqueue whose=
 number is \field{vqn}.
>  \end{enumerate}
>=20
> +If coalescing parameters are being set, the device applies the last
> +coalescing parameters received for a virtqueue, regardless of the comman=
d
> used to set the parameters. For example with 2 pairs of virtqueues:
> +# Command sequence
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
> @@ -1549,6 +1612,11 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi
>=20
>  When the device has \field{max_usecs} =3D 0 or \field{max_packets} =3D 0=
, the
> notification conditions are met after every packet received/sent.
>=20
> +When the device receives the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
> +VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands, it saves the values of
> +coalescing parameters as global values, and the
> VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command does not change the global
> values. If the device is reset, the global values will be set to 0.
> +When a virtqueue is enabled after virtqueue reset, its coalescing parame=
ters
> are set to global values.
> +
>  \subparagraph{RX Example}\label{sec:Device Types / Network Device / Devi=
ce
> Operation / Control Virtqueue / Notifications Coalescing / RX Example}
>=20
>  If, for example:
> @@ -1585,15 +1653,26 @@ \subsubsection{Control
> Virtqueue}\label{sec:Device Types / Network Device / Devi
>=20
>  \drivernormative{\subparagraph}{Notifications Coalescing}{Device Types /
> Network Device / Device Operation / Control Virtqueue / Notifications
> Coalescing}
>=20
> -If the VIRTIO_NET_F_NOTF_COAL feature has not been negotiated, the drive=
r
> MUST NOT issue VIRTIO_NET_CTRL_NOTF_COAL commands.
> +If neither the VIRTIO_NET_F_NOTF_COAL nor the
> VIRTIO_NET_F_VQ_NOTF_COAL
> +feature has been negotiated, the driver MUST NOT issue
> VIRTIO_NET_CTRL_NOTF_COAL commands.
> +
I agree to Alvaro's suggestion.
If VIRTIO_NET_F_NOTF_COAL is not negotiated, the driver must not issue comm=
ands A and B.

If VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated, the driver must not issue c=
ommands C and D.

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
> +A device MUST ignore \field{reserved}.
>=20
>  A device SHOULD NOT send used buffer notifications to the driver if the
> notifications are suppressed, even if the notification conditions are met=
.
>=20
> -Upon reset, a device MUST initialize all coalescing parameters to 0.
> +After disabling and re-enabling a virtqueue, the device MUST revert coal=
escing
revert to
> parameters of the virtqueue to the global values.
> +
Like others suggested, above can be reworded as,

After disabling and re-enabling a virtuqueue, the device MUST revert to coa=
lescing parameters to the one configured using VIRTIO_NET_CTRL_NOTF_COAL.

> +Upon reset, a device MUST initialize all coalescing parameters to 0 and =
MUST
> set the global values to 0.
>=20
No need to mention global values here. "all coalescing parameters to 0" cov=
ers per vq and per group of tx and rx vqs.

>  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
> Types / Network Device / Legacy Interface: Framing Requirements}
> --
> 2.19.1.6.gb485710b


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

