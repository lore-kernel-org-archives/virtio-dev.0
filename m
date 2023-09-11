Return-Path: <virtio-dev-return-13678-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222AAEE7FF4
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 16:33:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4C73B7950B
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 16:33:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1FA299864A5
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 16:33:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0433298642F; Mon, 11 Sep 2023 16:33:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E4592986445
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Sep 2023 16:33:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1694450005.773000
X-TM-MAIL-UUID: 2331f09a-e5a3-4e91-8d8f-3a8ca366aabd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Og2vrD9e+jqFtwnWU0o5gneJsYJYnaLdTBb7jzxXdzsvVrx6AHD13WtcySPFgE37/2YNmRxYfJgY7FnZ8V+DNeE+6iI7Af/7I5rTtjj+5bzZyrNieR4pfC9s0YyUYixEEmg7NTomPD4QFCTkdCc5sPZMEBoy7vQWsSq/sklx5401XE0iCckLpcXjHYEo58WB6N+sqElQVkuDveh/rfb3oizGUEAVvJPHWDMNgWOPat6cL3F0QSISHGPZvDl/D9nVhYoFLbjTtj5/2HrwMz+lkImzsEoan8WttmuWVcWt98g2ASodVzG6kIuZHIRRJ8fDBVy+Yj5jL9nrxfAlbw3qTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjGxzUhdNbo0vyQVWPdcra5Kteyn88Zm48Zp05i0j3g=;
 b=fgb9Ll/kZ0pmhIbeyvTShzCt6oIDTxUiHjqs+0M4ruv0xKh3K94mVOiRTcEuRzcdlcFQ3UjA0tkmXRTZUJHg0keyL93/jiU8i55JGI9ZsTQ1lw6X87CsRjlIFMu/pfoy6q/xgEpYhRTSD9OQLBAeN9E2MVMnAaOJuaQw+5kemzsYZ3hItnUvfaDPv/c0SMM6pJ554d8DT+HmjgoH1K7jielpSXVCoPs678PhC4JFARqfOBUl6AMH6qE8X0ERdvZcmWxNQLMjPSFEsdfPDVMhJ2TYC+34OYMVgxchHj5m+oVBLjXLfdfyVfBPL5gVKlVA2mQSND1qibkEvQW17NzXSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
From: Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
	=?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefano
 Stabellini <sstabellini@kernel.org>, =?iso-8859-1?Q?Roger_Pau_Monn=E9?=
	<roger.pau@citrix.com>, Alex Deucher <Alexander.Deucher@amd.com>, Christian
 Koenig <Christian.Koenig@amd.com>, Stewart Hildebrand
	<Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
	Honglei Huang <Honglei1.Huang@amd.com>, Julia Zhang <Julia.Zhang@amd.com>,
	Huang Rui <Ray.Huang@amd.com>
Thread-Topic: [virtio-dev] [RESEND VIRTIO GPU PATCH v3 1/1] virtio-gpu: Add
 new feature flag VIRTIO_GPU_F_FREEZE_S3
Thread-Index: AQHZ5JeMrx+qZaGaC0WWUrTpw2yj27AVyyFc
Date: Mon, 11 Sep 2023 16:33:24 +0000
Message-ID:
 <FR0P281MB286152665C939C9CE291CE63BCF2A@FR0P281MB2861.DEUP281.PROD.OUTLOOK.COM>
References: <20230911100430.1408168-1-Jiqian.Chen@amd.com>
 <20230911100430.1408168-2-Jiqian.Chen@amd.com>
In-Reply-To: <20230911100430.1408168-2-Jiqian.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB2861:EE_|BE1P281MB2803:EE_
x-ms-office365-filtering-correlation-id: 36738168-ec90-4320-2615-08dbb2e4d1a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EN0hhHborQ5j5AoB9Z0FZNkn56Hr2pdOyGjFN8CFnlWiKrJ0kW2TscuDyZ+tYdmee8tmRp5FGtEXCbdZOx7GFlTcnsjz5bXWoOhnG2Sz0L9tHK+hHUccfJ3QgOXZaX4eqOd9NGL1KGPp0dGe10+VCpZQZxC4BJQFYg6rE/kWaZJtSylJLAxWS0SGNpemlIcyqWNXWbH1RxswJP+NC1Jnvu/DICR+9M9pvzd5CTNmjBY/67vEF46SHJKSUV3KlPn71HEKWW7+biy1osocvGB00hnIjFVyQe9lYRQxX5G6ddj33Z5JpBveACOBLuE3PyYieErjV/eAALXg/7jz33mwAvUlAimrhYJrB7Cj7vXfp4hqv8gpWluU1vcN9UsnDL1nVAmliyV5n+B4SeklfFlK4q5W78xHpOq0/uSGLMWyhYpI4Em6qnRRvmY0pBCW9plO4b+69gwtLyO49IPucDIhNpUMGLfu9js/AFA9iWO/kksuByGtL7lcHHbDnBXulnZFRS3zj5eufVFUkt4b2DvzBIcmq8wO1fs6G2qlvUp21ibwv0HphLU/2Z9LnefnYXjXsxm+FgdqBMHnv6h3+LfK0/fBY2bkYAHTqLEMWJLCGgNwjqy2DiPkDLS2TCkRXDB7+OIkiz/gd77wfFuDIny0Se1x0WHWnEqKF49oLhngLcDc9QUJP2PtJXO0Gca/m+Am
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB2861.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39840400004)(396003)(346002)(136003)(376002)(451199024)(186009)(1800799009)(66899024)(53546011)(71200400001)(52536014)(41300700001)(122000001)(38100700002)(15974865002)(86362001)(38070700005)(33656002)(2906002)(966005)(9686003)(83380400001)(66574015)(478600001)(110136005)(91956017)(316002)(5660300002)(4326008)(8936002)(8676002)(26005)(66476007)(7416002)(64756008)(54906003)(66446008)(66946007)(66556008)(42186006)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nd9wOThWRCvYf2XC/6sD6KxbKxh/XRBpLmLEtEnrv8IuHSrO85mrbJ5fuH?=
 =?iso-8859-1?Q?LaI2HJF/r0cDgO8kJssnoO5xeEwAHpOnbc40oc36uumVq0CfGKS9dLQ0/J?=
 =?iso-8859-1?Q?vl+OurXun3fCHaq9LN4Ur25kSeb4oTqtQKhtIwydh1Lz6//ig05WCmqwUh?=
 =?iso-8859-1?Q?NDOPvCFhqM45v1VOVzCHY2Jv+dHBbUNxui9qSFb90Nf87sd38cWNuvVKkZ?=
 =?iso-8859-1?Q?Nyw/UPX0qi8/+NbwTbWgOJVHy+fo1M3SO/hRcyXZGMtc0vASp/e+4XDIii?=
 =?iso-8859-1?Q?5y7R5GJcoFSywzvQr37afNQiHIaKRu/AAhnvPTCf1SIGU7HsOdYAWd2ghP?=
 =?iso-8859-1?Q?icdUds6k1Qvu9IapuBLCXf19ToKeXrrJku7gH1ZERAo2BA5AnC8+/MNvwh?=
 =?iso-8859-1?Q?/dqXbnEtAeRL9+cTZ7T0gLLwuE7ERWUrZH9qme89k0An6ecNyIU6fcKrr2?=
 =?iso-8859-1?Q?wPf90uanQVp3sTDq/t2RYvrNJXypdPCDXjyHcaGzx1NHOYS/T+iqt+F0LY?=
 =?iso-8859-1?Q?XKGMLCGHs7bv6HgeJQ637ezwPmHQIg4qSO1C5010WCL2NlgNL6190P98Ao?=
 =?iso-8859-1?Q?O/Xae2XHj107XHpELbQ27d7fdFoBinFgBmst/BTVD1cvK63MGjX46WTX75?=
 =?iso-8859-1?Q?AdY+hIGkxMDIMGQF/H3wvPDeG8MhWmeWG/l5jDpRVvGNzGe772zALTxiTX?=
 =?iso-8859-1?Q?XoYi1UgzKZICGrHw7Hh/gyPtAXBh+r4vA7aYh5rew7UFjv2IJEHoojw+3o?=
 =?iso-8859-1?Q?97dUib1l434MrvjJ06yZkHcZAv4aGpgW+HjJA6JxX6W1x07bRMF3tTcw9i?=
 =?iso-8859-1?Q?xHsNzWz9VLB9iW1J69BUfcnU7iNJzOQsrj5Pew5Fr1Ezn9rzc4tAAo+JvW?=
 =?iso-8859-1?Q?JgnAnE/QpSHWsxT29Xkrf4ocY+bOAmmWI8VfS7yrLUZrDtIT/qBL4UNWuL?=
 =?iso-8859-1?Q?2vcm7mKuye6zT0Gk4l0RnQe+fXJa3zl+5gWys6E5uS/33ugg/mxHIyw4+g?=
 =?iso-8859-1?Q?MRFI2NKZmXY2S4Etae5SAYn7VEco96KDpAId/LO2DjS71/O2nmLHIJ2XVJ?=
 =?iso-8859-1?Q?vuoFLchbk1/orXKFmAMH3YD6yzWD2tnPxmJttyNmthKS36YutOaFG/WyoK?=
 =?iso-8859-1?Q?NBP3zaW9ot99r0c8XpVyj7tLHC9GePrrf1a7kpKqTIBXUxdT7/vj1k/TsZ?=
 =?iso-8859-1?Q?bQpwaZamsqcM3wEB3PQGRRRhrE2wjj+KoXrzJ4LumNhCeNQdZACbhm0sAv?=
 =?iso-8859-1?Q?twKQIiegdmL+uKfr7g85jLg7kl8eNg0pUJavrE67lUNE7GUcwpE1Esx+eu?=
 =?iso-8859-1?Q?HE/d4D6SKc9SGS1VC9R0nxAoNK7rCTMC+EfD+u1vJ4CS/i/oys+yROQUzu?=
 =?iso-8859-1?Q?AZnfISXmpTxyP/fPJO7p6Zl1irQlG4mEOk6K0FAI2cCA9opCag5aJYXsH4?=
 =?iso-8859-1?Q?dmZZSC+Qp+xAA2Qt3tpw3JgWDMhZghjlVr3YaOGN1/oEwx1kOmlptRFnE3?=
 =?iso-8859-1?Q?ChMPnsdt/VpbVJpXWmqDVaOPeCnepPNHehJqxhKgAkyNIqawtTP+MAOGZq?=
 =?iso-8859-1?Q?/XMHrlIViaNniDvrAtcntcTO13Uwb9eP3lRo7pvWZ5n8yNLRtwjZflc8Hv?=
 =?iso-8859-1?Q?GIWXozoYnMtpU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2861.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 36738168-ec90-4320-2615-08dbb2e4d1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 16:33:24.1858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQUFN/yoIlCNS/lZwy3j8yN2rLvF0l/HJXXbv5Ywaw9OBC3Q9JsXlgif/E2SBH6wLtvfhm+5R3JyVJ5deg/bMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2803
X-TM-AS-ERS: 104.47.7.175-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27870.000
X-TMASE-Result: 10--14.953200-4.000000
X-TMASE-MatchedRID: nI1cAR4k0Hb5ETspAEX/npGPSO6O5JCaoJ9fUBwJTsx+Z55KTeg3iZKd
	0Y/NwQWP70nqlR7yO+PEIW071TRcrgCyCXo9mCokbImvEGrHk0IHgEx+rhLN4uEKbxqb5I/nVkg
	o+mIOpAs4BuHRx5ISicFobjNpENFWsBFKnCBbSTX6KF0S1zktZ6wF9xFsJmUw6VIbcsw5Z9IKE0
	1KijBgBxoFYM0/xszzaD2UKQ7oadPJ3Kdb4xUXh3EayD3+TWEctYgIwzX+FnCrUVp6ho4UsJENz
	gz0AJOnjbzwHsVt3F988euoZaqdcGychE78+cDjJw66cQh/R5c3RfriMbLZ1uUfXoklmccUri/8
	EC+u4pyxsSmRwTLP5FltgJoA7ArZik3s3JIv+NJcB5L7DliBJYTH4XJVxZGKAtvBVlY5IReLz4g
	av4lvdTKT8fDhc32NeyxAIZ479y5qMVT08sQozLr2u0KWqQKNFkXEytHxBjlSITmUaxn9yO1cV6
	90qvCl7E4hcO6MtBbX0jf+J2tD8HjCKN9vMCFYx38MG44f3Tc7fkl66X2b72FHYdhaPYOm2KXam
	Sg6MzzpCHE4SoIsN8f5SKH2vMRFx10k8QqyoAwRLjqoJJt/9Tn2/M0Zu6bmoli4ZoiOHT9+ICqu
	Ni0WJAJSsHdNLaxFbr3VkAy6UaiNPidkUQ8i5eMWsSDxsHmrftwZ3X11IV0=
X-TMASE-XGENCLOUD: dfc4b4dc-c315-470f-8071-5187dfbb0695-0-0-200-0
X-TM-Deliver-Signature: 64BD32CB995BC426692A953F2890C4FF
X-TM-Addin-Auth: 01Hx9t/oTdK7RuTe5jCwj5sTGQRLGjaO9H8xSkiVdx3oFT6/p5KTO+CyfAf
	nlHgEBQMrDS1th9W32xfczEmdMjbcmNTmZfQNqAGgIIuGKELDmCsBtxa+NDtdihSXNeqTZNkPni
	BVfwD8gWRl+PMeDmIEOXqybMb7gN/AHY/ApmuNgGGuMiG6EG1aYknhZeatwxGEKJpI7Kzp/dk5P
	Rzpuo58peaZFooM1FXGYi3/vBOY3OBxtQKYQ4bb3PiGft+UTlR6xYJPW9FlqBbDFBCiMtNT78x4
	6U2yqaXD3oWNnwdQ/Ibvk24k4OvIlQCeeAy86eA2kQW1QWBRneCmUQbAVw==.KnbwfYfrdkZ6Ag
	e132ZI8niIRf/aOtkS75YoQsnluE6m4YdKkknXPjR4K12nOzuBucfT4fikPxWMhWiPjPTIwEASE
	1+M+63HiddUFWNqYqXkwinnfXF6Kh3b30iGdIAvl6Qg7i+0r3dBZAtD+hJlhZ37MvpbLeIBHczW
	k9gtdG2SI2GdWcbAcu8oONJzUAXX/TLzGrUeLvUhrzP5SU76AD/vrEV9+z42QuuV2ncPKwA38X7
	YlSMk0CNW+QuABmqQHbY9f/2gvHm/El/8VFyG05uGZIue1D41R+iaebrwhYPG8fJaFJ4nrXRBB5
	+bpwM3/HV73aFLXhqfSJrlp4RUhQ==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] [RESEND VIRTIO GPU PATCH v3 1/1] virtio-gpu: Add new
 feature flag VIRTIO_GPU_F_FREEZE_S3

Hi Jiqian,

Thanks for the proposal.

Some time ago I was working on the same issue with suspending the gpu devic=
e
(on arm).  Additionally, I had troubles with virtio-video device as well, s=
ee
https://lore.kernel.org/lkml/20211215172739.GA77225@opensynergy.com/T/ for
details.

In your case, the
VIRTIO_GPU_FREEZE_MODE_FREEZE_S3/VIRTIO_GPU_FREEZE_MODE_UNFREEZE do influen=
ce
how reset is being handled by Qemu, is this correct?  Since multiple device=
s
can benefit from the same mechanism, would it be possible to: a) have a mor=
e
generic, non ACPI-based name, b) make the feature generic, applicable to ot=
her
devices as well?


Best wishes,
Mikhail Golubev-Ciuchea



--

Mikhail Golubev-Ciuchea


OpenSynergy GmbH

Rotherstr. 20, 10245 Berlin

Telefon: +49 (30) 60 98 54 0 - 903

EMail:   mikhail.golubev@opensynergy.com

www.opensynergy.com

Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616=
B

Gesch=E4ftsf=FChrer/Managing Director: Regis Adjamah


________________________________________
From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> on =
behalf of Jiqian Chen <Jiqian.Chen@amd.com>
Sent: Monday, September 11, 2023 12:04 PM
To: Gerd Hoffmann; Marc-Andr=E9 Lureau; Robert Beckett; virtio-comment@list=
s.oasis-open.org; virtio-dev@lists.oasis-open.org
Cc: qemu-devel@nongnu.org; linux-kernel@vger.kernel.org; Stefano Stabellini=
; Roger Pau Monn=E9; Alex Deucher; Christian Koenig; Stewart Hildebrand; Xe=
nia Ragiadakou; Honglei Huang; Julia Zhang; Huang Rui; Jiqian Chen
Subject: [virtio-dev] [RESEND VIRTIO GPU PATCH v3 1/1] virtio-gpu: Add new =
feature flag VIRTIO_GPU_F_FREEZE_S3

When we suspend/resume guest on Xen, the display can't come back.
This is because when guest suspended, it called into Qemu. Then
Qemu destroyed all resources which is used for display. So that
guest's display can't come back to the time when it was suspended.

To solve above problem, I added a new mechanism that when guest is
suspending, it will notify Qemu, and then Qemu will not destroy
resourcesi which are created by using commands
VIRTIO_GPU_CMD_RESOURCE_CREATE_*.

Due to that mechanism needs cooperation between guest and host,
I need to add a new feature flag, so that guest and host can
negotiate whenever freeze_S3 is supported or not.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 device-types/gpu/description.tex | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/device-types/gpu/description.tex b/device-types/gpu/descriptio=
n.tex
index 4435248..1a137e7 100644
--- a/device-types/gpu/description.tex
+++ b/device-types/gpu/description.tex
@@ -37,6 +37,8 @@ \subsection{Feature bits}\label{sec:Device Types / GPU De=
vice / Feature bits}
   resources is supported.
 \item[VIRTIO_GPU_F_CONTEXT_INIT (4)] multiple context types and
   synchronization timelines supported.  Requires VIRTIO_GPU_F_VIRGL.
+\item[VIRTIO_GPU_F_FREEZE_S3 (5)] freezing virtio-gpu and keeping resource=
s
+  alive is supported.
 \end{description}

 \subsection{Device configuration layout}\label{sec:Device Types / GPU Devi=
ce / Device configuration layout}
@@ -228,6 +230,9 @@ \subsubsection{Device Operation: Request header}\label{=
sec:Device Types / GPU De
         VIRTIO_GPU_CMD_UPDATE_CURSOR =3D 0x0300,
         VIRTIO_GPU_CMD_MOVE_CURSOR,

+        /* freeze mode */
+        VIRTIO_GPU_CMD_SET_FREEZE_MODE =3D 0x0400,
+
         /* success responses */
         VIRTIO_GPU_RESP_OK_NODATA =3D 0x1100,
         VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
@@ -838,6 +843,43 @@ \subsubsection{Device Operation: cursorq}\label{sec:De=
vice Types / GPU Device /

 \end{description}

+\subsubsection{Device Operation: freeze_mode}\label{sec:Device Types / GPU=
 Device / Device Operation / Device Operation: freeze_mode}
+
+\begin{lstlisting}
+typedef enum {
+  VIRTIO_GPU_FREEZE_MODE_UNFREEZE =3D 0,
+  VIRTIO_GPU_FREEZE_MODE_FREEZE_S3 =3D 3,
+} virtio_gpu_freeze_mode_t;
+
+struct virtio_gpu_set_freeze_mode {
+  struct virtio_gpu_ctrl_hdr hdr;
+  virtio_gpu_freeze_mode_t freeze_mode;
+};
+\end{lstlisting}
+
+\begin{description}
+
+\item[VIRTIO_GPU_CMD_SET_FREEZE_MODE]
+Notify freeze mode through controlq.
+Request data is \field{struct virtio_gpu_set_freeze_mode}.
+Response type is VIRTIO_GPU_RESP_OK_NODATA.
+
+This is added for S3 function in guest with virtio-gpu. When guest does
+S3, let it notify QEMU that virtio-gpu is in what freeze mode in
+\field{freeze_mode}. VIRTIO_GPU_FREEZE_MODE_FREEZE_S3 means guest is
+doing S3 and virtio-gpu will be freezed, VIRTIO_GPU_FREEZE_MODE_UNFREEZE
+means virtio-gpu can be used as usual. When virtio-gpu is freezed, QEMU
+will not destroy resources which are created by using commands
+VIRTIO_GPU_CMD_RESOURCE_CREATE_*, so that guest can use those resources
+to resume display.
+
+Note: this change is not enough to solve the problems of S4 function.
+QEMU may lose resources after hibernation. It needs more research and
+development. If S4 is supported in the future, it may need another
+feature flag here.
+
+\end{description}
+
 \subsection{VGA Compatibility}\label{sec:Device Types / GPU Device / VGA C=
ompatibility}

 Applies to Virtio Over PCI only.  The GPU device can come with and
--
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

