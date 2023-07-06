Return-Path: <virtio-dev-return-13262-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC45EB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:33:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C89C2389D
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:33:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B4F3D986823
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:33:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A3915986809; Thu,  6 Jul 2023 16:33:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8A369986729;
	Thu,  6 Jul 2023 16:33:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+v1x66JcdDtV70aeydwDCxZblx0IYZKcX4NCkBYAbTYaO+Bvm2OCcC6oRuKPQHsPhwg7cDzSh9zRbFUILrhXulEn8OQu0LZixuPTGTEM95LDr7MBT4Yn943MwUFZYTB0ZGOSMxopawTu4fXz3/D8AWCl8QvCjhmdSrlv2ysE3UuBnuhu+iFG/Q4XKLRXiuLM4qhWbHrm8XUA+0DKOpoS61cL7JqES+EZX4KbDMVAEa/4GXzfrBoZkq3/8MdzjpyHz/hr97BBxjuPzUNSIOyJ4EURr69k5lPglu5aHhVzquuOmV3NHGs60Qu5+c4WZ7Z3oLJ0SHvxFqT7R3yly0v4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdYSPv8kb+g//d1wcRXFF5LGBhtlvfOsO7B8aKuaWl0=;
 b=cxdyTi/Kgx4/7zuG4O9V/90ueRJqxJS0k+dODGEhYg2xDcCyuADJkyM+Dw3QvCo1pXUP6748Anu5uR+HvZEpgOUbyRYwvBEMWHXsEBBqUj5TsSDn5opklxmbUO8ncbJmTLdEt+qbZslEB4/MDLAwgsTaEkNxXjgDyFoUpPNMxDv0o1ctGtzRJR2rd0U+ooOsO33wI783EyYG0WYOAjGaolT0lFIWc5tZcEmNpG2SKV5fo6+pUPxOyzG+eGAPU8e1CRxHemjVY77N9qHbx+j11LLuqcDSn/lyYDpEq8ISVkZZ7mrXU/HI7D5CowZmw9VBP47SVgTVvCjuBhAYT0dITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb
	<maorg@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index: AQHZr8EFxUk4agfAiUezeNF66UoB2q+s7j+AgAAAMsA=
Date: Thu, 6 Jul 2023 16:33:01 +0000
Message-ID:
 <PH0PR12MB5481ED484C57428AD3D959C5DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-5-parav@nvidia.com> <87r0pluhqy.fsf@redhat.com>
In-Reply-To: <87r0pluhqy.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB7427:EE_
x-ms-office365-filtering-correlation-id: 3a8ad3c5-1b7a-4b81-125c-08db7e3eaa5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UoBnKLn+TpcGQhHjsVGKNDlUEtdEHAjPL+2trVOfj3VvlDTrIwWsPdnEuGFZ1jb8ioP8z8XpcNhdHaNgz+TZHQyBeDkQPOwX5otGERqnoXQElYCkovI5tMP4PNvao8og1NW2y29bn3CcNxBZtOGuYcG/ZJhHWkohSridOxOWrHkwlXiUku5WHcL74tAyc7jSAA+q+4IJ91OQo7D15UgT9/Gww/Q9252UDpfmVAsI0zJV7EY1Psimddlk+5rzMoil4vC0HLR+ygHjskiUPcigNR/jI9yUzIglc1eNKZg/oiJOqmKepviaZOKlotaRsDd3Qo6O7653m/0DZMpYK6/bZo1ciBKZDgz8WUMmkjId90KhHb1t11KBYTC0Y4c6gZcn1e/LZLsljsLv3rNk+FKfNmWt1s16Rd/GU+qQ6ZcHaGYt5qUJ0NobUpSZuEAUWY3J+Tdj1zts8Ub7f6MGr/si521aFMoLah4XqiMhJi0Z9JERWPka6n9/uCE1rFBqEOpfvtxSLtXz9nub2+HjFUW+ZaF/CMDdxuIh3i4VPQHDL399K05bhfVAl8y/aCPAcv9InOuh0G2loPTtXVXxRLg8ChfSXj38ZZDAoGRQL0KjeRFIz7atbIAFTsU/GPOBhlPp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199021)(2906002)(41300700001)(5660300002)(38070700005)(8936002)(8676002)(55016003)(33656002)(52536014)(86362001)(71200400001)(478600001)(107886003)(6506007)(9686003)(186003)(7696005)(4326008)(64756008)(66446008)(76116006)(122000001)(66476007)(66946007)(66556008)(316002)(110136005)(54906003)(38100700002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?frBH2sbGtca4v2xqCB4+bw1iMX5QDdZsmQzhNzdY2Hkr8/eApzO3aAjP2S5h?=
 =?us-ascii?Q?R956YyE2eWVzNGaNAsM6/jGwsrCwOxvoxrR54TfO8YWlIkin5ShYypFW3Pjl?=
 =?us-ascii?Q?wLQWeSUxSeJQq86lriQ3g2co1Q7nHYL5dYRw4DygtTuNequgWapLPvbFUO6u?=
 =?us-ascii?Q?5PUI60j7ztjeEzGEnOsTHpxx+SBQJ94DD/zyxRCPswhoywMWOrpiKE8wz2Xz?=
 =?us-ascii?Q?L65IrN3o/xCXpvccNDF63v19Yen1WXcA9WGYgo8lMJisSdjfyBrrAKCB+/gy?=
 =?us-ascii?Q?opgHB3ro2+iELjBbEZEde/Suw/UNIYvSsDeBTEi7LCU0nzbOGFM2YTU50Q2e?=
 =?us-ascii?Q?QDYHbvhZm3T/wBK6/A2SdpTRKfXeN6DZr8Mcz6aDXz+OOF1har9THI3CA9z4?=
 =?us-ascii?Q?nM4m1HMPZHf8cLNkAHG4tfVkEVg9+rxrGoXnV4+g8ivxjsdXEEhvwAoQwMLh?=
 =?us-ascii?Q?/7QDKf5senjORIIX5zX5d5+dqjfnMfvPTWkMbaeuuWvvlg2RLMQx9nntVw6d?=
 =?us-ascii?Q?f8FJa7rvi+1KfI3cBamdQ69DxpANf1ajers5KssxwAxVYOd7dYht2+mEHjoI?=
 =?us-ascii?Q?6r8LYKAw6x1EaladyXmvERzmB0CDAI4yJ0i2MJQpHEYs9F6oIHaOT+uSyEyP?=
 =?us-ascii?Q?6wUdt1X8m91g7TO5A98SGEZbw+qGMhDlBq8q463ABBpcIKerFrawz3QzRn5Y?=
 =?us-ascii?Q?ix8xNKkKq3xWxkt3kE0Pal98CBRDtpogogQ2wgnuPBPdDkLenlYd8zJgAdaH?=
 =?us-ascii?Q?7XQHKT1S3RKQCPkzjF3bSHN7lAJurlkjKSTY9cvmgtcz2B+gULr5VuGbUOne?=
 =?us-ascii?Q?znjDptj/YfMJ4/60x6abgkdt1Li3oZPlTg3kVcZHjLtN2sQ54rtCWMe7O2J1?=
 =?us-ascii?Q?OiY2ItQYsajARVPuOqukmqwT053FFRV827bUWlA2dt1Vf5/fST/V98/yd1r5?=
 =?us-ascii?Q?xpR6NirAVW+7GVyB+AnMR95Oj2Pn0m6+47Y2ITdxfHuCE2yGx9l/JYPnGjB9?=
 =?us-ascii?Q?ZmYnbRfF+N/XROGMc/IokgVMOrqnU3ZGJh3gPxFuJdpD9gp1jeHzLyaICq7n?=
 =?us-ascii?Q?bFg1+ggsJa274clbTAuigQLdPDbdXZOn+WPNAotDUvuOhXp7DJAAAPenCg00?=
 =?us-ascii?Q?Up4iBZ7rrmQ+CwH5+LL2ZfNpbFgWdyAuVKafCx/dtrveEIY1jTj/BaeqHGbp?=
 =?us-ascii?Q?JHpyrUs4/KebjlHTs1e+lPQKeSe/K4Vjoq4XRyX/MNT2JQQGC9t2JvBv4Idx?=
 =?us-ascii?Q?nntcln6yf7SOC1425LZkxsjrP4klAbIY2+X+eWRoVWKzG/Tq7rSlNrkJ0YNL?=
 =?us-ascii?Q?r+jlxKGxwIrchuOE9kozAoXwDewxnCU+WkTQmPsTe3b84PyrE30v250gteo6?=
 =?us-ascii?Q?R1Dzl0T56bNUED1FwrdfmZS7g8bvqUwKhD2CaeXZeLDuJxg7kPnPDZ39hL93?=
 =?us-ascii?Q?O1pG03307u9fs72ap6+2uz8921tkaIUiaBDEVqtfr0RnAWFghKCUnbh+7TLZ?=
 =?us-ascii?Q?SatV3oXsLvlzQD18rq7dYVs45iJeLL6oIuQHLIL8c8rEX+dgatrq6IiXAJTk?=
 =?us-ascii?Q?hwfIPN2k4N8LHCk0ljuFEPrL1sKJUqLXRa85gw8B4B+Al8g2+GtuHnjGXvMc?=
 =?us-ascii?Q?wJuzLtYDhJGdoewTdTKcIgE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8ad3c5-1b7a-4b81-125c-08db7e3eaa5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 16:33:01.4114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WFA/oEjLz/DDwhLV1dtqe/MchgJIP4kd+TuiNv2G+7pocWg5SQTFkjM23PV7SiTfAZs/5YDHYpx9f4Q/6rEiXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427
Subject: [virtio-dev] RE: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Thursday, July 6, 2023 12:28 PM
>=20
> On Thu, Jul 06 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> > diff --git a/transport-pci-legacy-regs.tex
> > b/transport-pci-legacy-regs.tex new file mode 100644 index
> > 0000000..ceea28c
> > --- /dev/null
> > +++ b/transport-pci-legacy-regs.tex
> > @@ -0,0 +1,42 @@
> > +\subsection{Legacy Interface: Group member device Configuration
> > +Region Access}\label{sec:Virtio Transport Options / Virtio Over PCI
> > +Bus / Legacy Interface: Group Member Device Configuration Region
> > +Access}
> > +
> > +The PCI owner device or the member device or both support driver
> > +notifications using
>=20
> What about
>=20
> "The PCI owner device, the member device, or both can choose to support..=
." ?
>
Fine too.
Any thing wrong in having or as above, so I don't write it next time?
Or that in current form reads better to me.
=20
> > +a notification region defined in \field{struct
> virtio_pci_legacy_notify_region}.
> > +
> > +In \field{struct virtio_virtio_admin_cmd_legacy_notify_query_entry},
> > +\field{region_data} is defined as following:
> > +
> > +\begin{lstlisting}
> > +struct virtio_pci_legacy_notify_region {
> > +        u8 owner;  /* When set to 1, notification region is of the own=
er device
> */
> > +        u8 bar;    /* BAR of the member or owner device */
> > +        u8 padding[6];
> > +        le64 offset; /* Offset within bar. */ }; \end{lstlisting}
> > +
> > +The group owner device hardwires VF BAR0 to zero in the SR-IOV
> > +Extended capability.
> > +
> > +The group member device does not use PCI BAR0 in all the Virtio PCI
> > +capabilities
>=20
> "in [or for?] any of the...", I guess?
Will change to "Any of the ".

>=20
> > +listed in section \ref{sec:Virtio Transport Options / Virtio Over PCI =
Bus /
> Virtio Structure PCI Capabilities}.
> > +
> > +\devicenormative{\subsubsection}{Legacy Interface: Group Member
> > +Device Legacy Configuration Region Access}{Virtio Transport Options /
> > +Virtio Over PCI Bus / Legacy Interface: Group Member Device
> > +Configuration Region Access}
> > +
> > +When a PCI SR-IOV group owner device supports
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE commands, the group
> owner
> > +device MUST hardwire VF BAR0 to zero in the SR-IOV Extended
> > +capability and the group memberi
>=20
> s/memberi/member/
>
Yes, already changed in my v11 where patch 3 and 4 content is merged to sin=
gle generic section.

=20
> > +device MUST NOT use BAR0 in any of the Virtio Structure PCI Capabiliti=
es.
> > +
> > +The group owner device or the group member device or both MAY support
> > +driver notifications region.
>=20
> Make this "a driver notification region"?
>
Notifications are generally more than one and spec has the section "driver =
notifications", so...
=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

