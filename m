Return-Path: <virtio-dev-return-13241-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B59DC001B0
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 16:36:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 66019C623C
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 16:36:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4FAE2986812
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 16:36:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3F7CF98672A; Wed,  5 Jul 2023 16:36:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2CF6B986721;
	Wed,  5 Jul 2023 16:36:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EK1g6pqFLeR7y1VQ8UA2DoNjA7X4fpXYq6YOI6awMLR39mMy0UePVqNUpnRGW58i6cjbg7jPQMVKIjePX8uaKU4OyLH2UYzSTtnqAsy2FJRJBdABLsVfCzCfamos+BlKtu0kWI/kTN0FXpQexhoENg4zUFSeG9zStJArPhfQuMkxjHGjub8iIy984wbRisNSZP1WDvOPkCS/l1qgEILEwDUAIS+vPsfMgHCvJyGZrlN+kcgiUykKUF0+3CxVz9R60oaVbE9bxK4WBZx36iJLwsyD9MzJjYogyK/ZWHd5iVGe79wgUbK6UeAo+UQhVng9vG27vAJbDxw9K1zLbPZLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UWoAy1B0/yC1Omojz/5+5jOZuk0g+dmLakNMs6LlW0=;
 b=ZHorVml1r51x+OC8uyfM+sTpz01mWiAe8C76bHf9u148ujZOmJCPqtySOA/hjoo8YRdXzBtbIBdNJnZ5z5gryrongvSA7Ivo9syXC3PPxJTZGIHJxYfDCcJi9Lj/nqh3YjAnN2FES5anpiygkNlMrLwF4rcP3UEXUIu+0S40fcpcDdf3TdXs05T45aKRbEtzdyX48lbZsS/9v7VjuvO+ydyr0NyBP7luJSW1aZAFjW8FdGDXQJlronDBshD1l5EDQv2JGnx2XmggSV/XjrNjDfnAwq/MiCBshLdNg4Yddmttuqergg8G6oDoZZmBUqhQHG7fu9ktHGkbelFk/6khiA==
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
Thread-Topic: [PATCH v9 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index: AQHZrtCMEY+SQTJ/6k6oqr4+BsS9Ca+q+YMAgABmEkA=
Date: Wed, 5 Jul 2023 16:36:12 +0000
Message-ID:
 <PH0PR12MB5481061EE63897B84FF0105DDC2FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230704233724.22394-1-parav@nvidia.com>
 <20230704233724.22394-5-parav@nvidia.com> <87cz163b3t.fsf@redhat.com>
In-Reply-To: <87cz163b3t.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB8189:EE_
x-ms-office365-filtering-correlation-id: 2bf78bb7-b9cb-4ed7-d1b8-08db7d75f1fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aM2HTUbqYSdJi2rr4B0yJjYmz/GX7V4zc3qerMZSoKVhomQrDiOi5ST2OT+bUMroW3xOu7fTJwP0RXdJlk+PcsTMl6cV8GABL+OXBN86Op7/12ox1OzHG+jhbHQUTbLXoAFFVt+0ACCjVM0RM9twf38xR19C4JmvgDPLqy3lMQP2Sy6XjYSsADZVlxZOQKYRccB5SYXRUBIACfkWiv+Git+jd0R1MElKdAWKB2uj/4kx844EpYkSV2aZ0O/kOY7tP0Qw1EoI9zp64cJvGFiwwQgx8hXX+4QnUkLotxMEityKT/+KqdNvw/UTEdvFsX60Xm+LBIvGUzKF4aDlA7fqtzCWo8GXefTRDyzeg5vF2tDgwfm3y33lvkiE13SIPntmBry1MRTZmySvLGgmA6JB7EfKtlDqFMLT9OIh9T8bVsU+2PWmAc0WvIgdujQHLEQe8vabZ4n9dXcSaSsRHpUlEIwaW5KoC8I6gUqL415HefaubMN9F/rR/Zb/Go0yN6Bd8bQaqnV/XoEEHtdQ9iqCYHYMieo6YSxnhK3B56D0HLOL382G8kqFn5VH/TgFcf3Mzkb8/8eKQnGihM5nzGwvZHcjhagNrfG51bs8/HqlTVpZNG2CA0uOYw5oskTKoOlT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(41300700001)(86362001)(38100700002)(122000001)(107886003)(83380400001)(71200400001)(6506007)(26005)(9686003)(55016003)(7696005)(110136005)(54906003)(38070700005)(478600001)(316002)(66476007)(4326008)(66446008)(76116006)(66556008)(66946007)(33656002)(64756008)(8936002)(8676002)(186003)(52536014)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LLv+fjoxHU6XDowgekujYzRwYRmYUWWsqy9icRqm9jC13aCFv++tVyc01xso?=
 =?us-ascii?Q?E8k1H2gfTyMiGcy/UunEgzTE8n0kGKq1wUdvJ5oxZJFRRMCVJTjrJtVdrSLE?=
 =?us-ascii?Q?/oHqQSHdNwRO/7EHUxn+cT+xPtPW0aLKXxSRLrp3EJYSq2tdRa47nrigJfgV?=
 =?us-ascii?Q?YkVBEzp81Yf9poWVjPLBN/4G+l4VrMYZ5yfDBK35EjBt31fvs8il5jBotMMD?=
 =?us-ascii?Q?A5whXa5sybQ9sSTIf1kn/UQLchQTbkS0hWCKRpW0ZU10ivucnlM/a/PDHZ9g?=
 =?us-ascii?Q?ZULJrPQdZOEVfK8zGoPGrxuwwwQv56Whq+GSA40KVchd1dwKqXYyMlPGeF4T?=
 =?us-ascii?Q?8t/75fl3JsTSNKhDTnPfKzz1SYd3cgxsbdVu0PxRPijTfO+fxWiXAItHn3Wr?=
 =?us-ascii?Q?pVIWljfUULyEUHi5VicrAS1SepRkG/4nupF+jaOBNPoW39gjoBeJMInDlTU5?=
 =?us-ascii?Q?Q1WPOs7DX4PFUHcjAEah9Q3rMvkpN6hIUWPQ0wKNmmxKEYMPiFTu6Og0x51D?=
 =?us-ascii?Q?Wm/55EEhw2D3Rt0u7FNO1Xazt7c9j/TgcBH71XlxkEUFPOL1ki52j7mQ6rLi?=
 =?us-ascii?Q?REyZMIUU/8Lh+qyMpauVGmv7bKAilBgnuCIIlVivzhZmnDkW2Bvi5c37wKPG?=
 =?us-ascii?Q?IrXetQhtnIIAK3qlmbZ6g0oscpaIWXV+kIgEJBdMe96DQowQ5DxUcVKNFVvl?=
 =?us-ascii?Q?HHpGrxRCM3NpLEkejj1iyjjSeAdOWoFL/4HgJtrOsdz5PW7AnSbiljzc6rWg?=
 =?us-ascii?Q?h6VJQ4cpPICblS9LvAdLDZTtTXT4uIj7nv3G5nWFx+peP87XRmdG5/QXNnbV?=
 =?us-ascii?Q?cpCgHmfv2ryrSNj6j1oPZl5SxJ1pGNLanlAwvhmBrOHSvQSbNZQzoYxAeHKn?=
 =?us-ascii?Q?dES3HxMUV30ZrszIoXl1WP4JEqrtJvjf4/yF/1XrQANweck3kwQdjyLgVIja?=
 =?us-ascii?Q?Dk2yAcDOvSuW0cohX5v1/47FURZVdFugkWJnTPjt+EjONn6iBj5N0Vp0QU5c?=
 =?us-ascii?Q?5BJyp8cvIZjX83VKEGG7aiWSJsyJY3a7jjvWel4n6OLDlUgyNyt/SUepspHl?=
 =?us-ascii?Q?IPbGV2mwS6IIrYKVn73DBKXxBnN5tCT4Xnu6C2E1JnAAwcK6ihGEqBTlfDw7?=
 =?us-ascii?Q?1vATYrriTLIcJ9o9kQe4pZyTyLwlOCl396EFX6ri1ZXN9d1RIhxLMGNPzGnf?=
 =?us-ascii?Q?zj4u6ssbOg7r+GOHroLGZ7yriWu9lZXCwWysSRazYZXq3W9sC96XWdxPUfaW?=
 =?us-ascii?Q?gVt6T4S0UXbAPpxGDtM8rMUrpnHTNv5VUbG1/TWha1uBCNexIvjn8xwImPZf?=
 =?us-ascii?Q?j1Jg1GfDtZ6Q1HnkuVMHlWO+zSzOm+9tmCmgZBRwzJimH/Gu6URJ4V5gfR+F?=
 =?us-ascii?Q?PomLZtYi9hpMpzEoKEnZPmEXPav60Eza5nALvmOfee/AjAGZzXLtd2U21b1R?=
 =?us-ascii?Q?y7GyqAkjgywP45PoH0dk4GKAaQwnOsUukBwkiDolNykKm+hyGnO24E8y0C7I?=
 =?us-ascii?Q?kDuhT7l+AyfSUmkMbKrLEbeQnrEPBdUTpA9y02iqsO3yENCpbXbzwBAis76i?=
 =?us-ascii?Q?5e0TEcdg1aB/CreS1Eg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf78bb7-b9cb-4ed7-d1b8-08db7d75f1fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 16:36:12.7128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l0RMj2UrNUrVWOqQo5v6T42bb1R/MlJaO79khfuL490FsLnjODzHi5nPl/jQzjCSGViHvLBhB1xXcLBdZrpUYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8189
Subject: [virtio-dev] RE: [PATCH v9 4/4] transport-pci: Introduce group legacy group member
 config region access



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Wednesday, July 5, 2023 6:29 AM
>=20
> > diff --git a/admin-cmds-legacy-interface.tex
> > b/admin-cmds-legacy-interface.tex index 09001d5..571b256 100644
> > --- a/admin-cmds-legacy-interface.tex
> > +++ b/admin-cmds-legacy-interface.tex
> > @@ -150,7 +150,7 @@ \subsubsection{Legacy Interfaces}\label{sec:Basic
> > Facilities of a Virtio Device  by the device.
> >
> >  Refer to the specific transport section for the definition of the
> > -\field{region_data}.
> > +\field{region_data}. For PCI transport refer to section \ref{sec:Virti=
o
> Transport Options / Virtio Over PCI Bus / Legacy Interface: Group Member
> Device Configuration Region Access}.
>=20
> "For the PCI transport, refer to..."
>
Ack.
=20
> >
> >  This command is currently only defined for the PCI SR-IOV group type.
> >
>=20
> (...)
>=20
> > diff --git a/transport-pci-legacy-regs.tex
> > b/transport-pci-legacy-regs.tex new file mode 100644 index
> > 0000000..e4f70c9
> > --- /dev/null
> > +++ b/transport-pci-legacy-regs.tex
> > @@ -0,0 +1,41 @@
> > +\subsection{Legacy Interface: Group member device Configuration
> > +Region Access}\label{sec:Virtio Transport Options / Virtio Over PCI
> > +Bus / Legacy Interface: Group Member Device Configuration Region
> > +Access}
> > +
> > +The PCI owner device or the member device or both supports driver
> > +notifications using
>=20
> s/supports/support/
>=20
Ack

> > +a notification region defined in the \field{struct virtio_pci_notify_r=
egion}.
>=20
> s/in the/in/
>
Ack
=20
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
> > +The group owner device hardwire VF BAR0 in the SR-IOV Extended capabil=
ity.
>=20
> s/hardwire/hardwires/
>
ack
=20
> > +
> > +The group member device does not use PCI BAR0 in various Virtio PCI
> > +capabilities
>=20
> "in the various" caps? Or "in some of the" caps?
>=20
It is actually "all".
I will change it to "in all the Virtio PCI capabilities".

> > +listed in section \ref{sec:Virtio Transport Options / Virtio Over PCI =
Bus /
> Virtio Structure PCI Capabilities}.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

