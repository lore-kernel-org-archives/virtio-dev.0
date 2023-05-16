Return-Path: <virtio-dev-return-12723-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF2EC77B7A
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 18:46:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 820DA1395ED
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 18:46:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 63AD09865D8
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 18:46:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 538C0986579; Tue, 16 May 2023 18:46:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3CAD6986549;
	Tue, 16 May 2023 18:46:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKRnstEc29siG+mADZH89DlJNF6FERpwopGQIotzaWqTGVMLbwcszAHEfivsLqL7TLtSzk6hqT8QF/FBSkTOaQzieprid+qSF2MGJ6+rrDT1e9yl1MZi0K7oDqDmaox6whe/4OvprKv+8NhAAgPbCBgE4oa2tUrThbuFlOYkmn0qXaqeUis0nwrQ9Gunhj/ZgMOhk8Sj4ofySWFY+LapOCzt5nKjZUGnTMMhBJvKhuyTPFYtJLjgmGiBy9KVYBSndO7U0U0xFkN+Eezox2BA0UkbZo9gGAEAhejLCN/U93hyh9dTlQzFQHYWg2sqU8QBLHW+QvE6Scu/IKGKUHmRew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ggbgmr2Yb2xkGwdvmY3+tFu0whnwkqPSgKGwXq5kww=;
 b=I9u/++rSYjxHnQUGhEBhUz0q9l2MAtOwoTWWP5BX/XtdfEoFymXyFZiqBqPsdj27Xv6oo/H8VFzR2QgV6XNu31CCUd7uYppDJH7UqjKhJUrKw9rc1bQgdhkHVZ6BkyXnb+WEC5gDmhDljFwwhKcxF+G79MnXXavQwwdOiI3O3TQ/ETTIvqO9nxzS7d5BDmXu+lzTFljmF90Ex7TDwo+SwzM2/JFwJ91fBSuhVx6mt6ATdVYQPIXzTvyQyB9353JtWFHKhT7+HQjpB893CmF0vIMyvfcsTg6Jueae4e4ls3Ls4YAvwzsd6KgK1LryecHk0hF+HcF8XeUpxe+7GAm1Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [PATCH v2 0/2] transport-pci: Introduce
 legacy registers access using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9OhmIAgAIV4oCACzxPgIAAAMrggACGNgCAAOnCAA==
Date: Tue, 16 May 2023 18:45:58 +0000
Message-ID:
 <PH0PR12MB5481E016C2467E5C4CE8FD25DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <20230507050146-mutt-send-email-mst@kernel.org>
 <71d65eb3-c025-9287-0157-81e1d05574d1@nvidia.com>
 <20230515155212-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CDAD2698E8078BFFA4DFDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516002024-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230516002024-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW3PR12MB4569:EE_
x-ms-office365-filtering-correlation-id: c24ead54-c8e7-4040-08ee-08db563dc9e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EviW6+XX8bpw3ltUUFRWN5ZleFCxQ3UOYr4ylSh9CsTfx8YgfURtvD0xstDakkklRW0rCN7pWHxO5NgU2wl6VSo7mCmL6nNh9Ny4jkDu5s3AYukB5b485Vz7GzRwr0ZPkMRTuWbONJaWjsuaqfbZaZ3byjPNNbX7iKEf8clwZblkeFS7j1HYgOOknBIVGYvCE2JZSzio9C4CS8RjMT0oeBc6nv586pkKwqRCHhjpqgvcITUF6uCc9WIeVzRPbm0lQpINpa+QSOiYQAcrVxAMI7nq278N59g33DYMg3xA6+5hrkQkmXQ7YfSsDlX4cUOpvnhtQ3AEAX8PLhjtLpXjZolev2+Io0m7958lEZOTWpHDClcpATjmz9IQjcdwTKHDJOiEw4Y6hea0p9iwZcO1Dva+au7C2fpfaZ2fIB9BGWSbeqVxv6A2mGhS6KgiMTvQAgLaOrh1uiexTY+cdsa+VSnjJtaf/iTmkkFbsSGVRRNxrP4XyH2EIQYhQEfia5fpjTaxrsTxROK8bKnQQ6sDgy/ehTsHa1ztrUJ67lshOVxmCUsur6g2+OWOYhXNbnyFh52xKfJGn31v1EqyeqFizES657wMrV355VIqZaoVhHlHVBrfl3JvRo80BJodSHp5xno1FndB+SJzjEWzxynvuSLTc8Dk8r611JznQfMDzwA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199021)(66476007)(84970400001)(64756008)(66446008)(76116006)(66556008)(66946007)(9686003)(107886003)(7696005)(6916009)(316002)(4326008)(478600001)(54906003)(71200400001)(41300700001)(5660300002)(52536014)(186003)(6506007)(26005)(33656002)(8936002)(8676002)(55016003)(2906002)(83380400001)(38100700002)(38070700005)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pdD/JfvtpmjQXGD4aTNzK1IeHQju6RsdLewcksb23LOUBJfyF3K71xg5VIo1?=
 =?us-ascii?Q?Y4iVC00KLcTBzqnqiLd+HrHOVq5+Ql7X1HizD05jj6Fg5p/SGA16Nnm9j1Gk?=
 =?us-ascii?Q?b8Tcwo6BCJ+/OWAWrWAwnLjWa8SGO4mDbgENwnxhLzsuF2DSkShM5YuyMp3v?=
 =?us-ascii?Q?2K0LZCIiYvp3Go63jSMXmds3y9bVDWIrEoRxyokFtKHNAwNqqBVgVjg+Kb+8?=
 =?us-ascii?Q?6gsO/RX11w4THUt6nW++hikp1BJTZjggbn1Pww29Jp/lxiXtaYZz3vtx+/gv?=
 =?us-ascii?Q?WgZJbFPRZsXCFtNPL7yFi5wD3yIkk8NVEv8uJh/Ti64ensqF3N0atQJebWlD?=
 =?us-ascii?Q?qlaHCZcahoTm3T/+PzR8o/jBlZA0hTkiL9TOo5QUDj2txIqVf+PdlJj2MGBG?=
 =?us-ascii?Q?g10zcoRvx7U8Rx/V5rYCGLVgjNGgiUC4jxMa8z/eSHXIPRhBb3ZMzhncJBB+?=
 =?us-ascii?Q?F5VCCJlI2p0P6ZCR3dZ3pfmkVmdCIeckFwYseZmLADanRAREIwQsgnPhDXM0?=
 =?us-ascii?Q?oPWlyEFATm+QPCCpXM3HI9hF9KuTa1Mnev6k9+vtbSl+9XKl21nd5s+/ZlOD?=
 =?us-ascii?Q?uphJytluuWk9mfjZ/I6tUGKfog/+WAgN6wPHeOI4kEy/80CsvPdZ8UfnOQrJ?=
 =?us-ascii?Q?wfgzE175CsmH9hGmviE2WsmbmglVdJKxwFekBvvC50dKgjJn1JQ0dFS8l/DD?=
 =?us-ascii?Q?BK8v8WFR4FI6JcRKWEucdmiIlXzwvTIDuXVO9dV05tMEYFgpX8xstkfAWY70?=
 =?us-ascii?Q?QOFIkIwCNFrFAzwjHa02CzzzRnz7hVMMze08Zuk+ccQhew27tHPKaD2/1OKY?=
 =?us-ascii?Q?6QzsAZ3R9l7krTNgh9Ly3Hx/Bj0IG6nNNMOkR3mCp1b4rn1DfEdOAKfbV442?=
 =?us-ascii?Q?zjtCjl38crhnhLH+L4nKFZbrMZw17GN2qPMH1BRp9B5G//22i7j1G4UMPJve?=
 =?us-ascii?Q?m6K2mpy3r/QzULLDkwYuUsiqpItR6R7BDaAeplJhDt1wSI3yHAMBv26crHBE?=
 =?us-ascii?Q?70yJ/X7V9LsmlprEDjlzR8tAHZdx0JjvIWHQPXAqtClLf5SCHCQumz7HwZce?=
 =?us-ascii?Q?AixLgzkqeiqpwmsocAePwrma+O9q+rksA5PxPpfq8LDS0IL439TkafetHPhT?=
 =?us-ascii?Q?W9Mgq7DZjzATLSkuzGxi0OJSjLvzqp3obLxTgtVWCqjoUVh801jHa6XJmAgc?=
 =?us-ascii?Q?DR3mE01E3yIFdh8w43T141Lc5Y36I3+ZFOWwzFs293W8INx17TTT+HAvpPCi?=
 =?us-ascii?Q?ea06MYhZN+WWdYDm1OvxK5yPxM70QnmYgqPrxULKHny1on+ineGNBONtqjlV?=
 =?us-ascii?Q?MkdcayNiqBq0OQpcJNb4B7sb4lJdZ2E7EsvvAM7CSQMcyqPK5jeWMo4Mx31p?=
 =?us-ascii?Q?8tbUULIVvzsbBTcojvUvZFXRokXrzOb2ro2QXQZgA3DDkD1fpq14t28WjSHF?=
 =?us-ascii?Q?JTyI7bwiiwxGbJhohci5ilwHhH/3duTCMlqwWnZ+l4NVW+V1EcJtsbPxV/FL?=
 =?us-ascii?Q?S4nZn8GEm7BIFg6cNhv5D/1Kvel0PgQWjSG6WoPwwqmESxRW53aQYzIJg3mU?=
 =?us-ascii?Q?2GDe5mupyCzv99fd0yk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24ead54-c8e7-4040-08ee-08db563dc9e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 18:45:58.2837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HW9xde5fNSR4jcZZzeYWRBILi6uevpPDEsp7o252uWmo/4MKRICGPi8jdU+wlxRaaBIsKKk9R68nH6KxfMCbpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4569
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v2 0/2] transport-pci: Introduce
 legacy registers access using AQ

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, May 16, 2023 12:33 AM

[..]
> > > > A better way is to have an eventq of depth =3D num_vfs, like many
> > > > other virtio devices have it.
> > > >
> > > > An eventq can hold per VF interrupt entry including the isr value
> > > > that you suggest above.
> > > >
> > > > Something like,
> > > >
> > > > union eventq_entry {
> > > > 	u8 raw_data[16];
> > > > 	struct intx_entry {
> > > > 		u8 event_opcode;
> > > > 		u8 group_type;
> > > > 		u8 reserved[6];
> > > > 		le64 group_identifier;
> > > > 		u8 isr_status;
> > > > 	};
> > > > };
> > > >
> > > > This eventq resides on the owner parent PF.
> > > > isr_status is read on clear like today.
> > >
> > > This is what I wrote no?
> > > lore.kernel.org/all/20230507050146-mutt-send-email-
> > > mst%40kernel.org/t.mbox.gz
> > >
> > > 	how about a special command that is used when device would
> > > 	normally send INT#x? it can also return ISR to reduce latency.
> > >
> > In response to your above suggestion of AQ command, I suggested the
> > eventq that contains the isr_status that reduces latency as you suggest=
.
>=20
> I don't see why we need to keep adding queues though.
> Just use one of admin queues.
>=20
Admin queue is cmd->rsp mode.
The purpose is different here. A device wants to async, notify the interrup=
t for each VF.
Like a nic rq.
Filling up the AQ full of these commands is sub-optimal for those VFs who m=
ay generate interrupt.

> > An eventq is a variation of it, where device can keep reporting the eve=
nts
> without doing the extra mapping and without too many commands.
>=20
> I don't get the difference then. The format you showed seems very close t=
o
> admin command. What is the difference? How do you avoid the need to add a
> command per VF using INTx#?
>=20
The main difference is it behaves like nic rq.
Driver posts empty descriptors, device reports the consumed entries.
Specific entry is not attached to any specific VF.
The eventq_entry structure is written by the device for a VF there fired th=
e interrupt fired.

> How do you avoid the need to add a command per VF using INTx#?
The empty buffer is posted pointing to eventq_entry.
Total number of buffers posted =3D number_of_vfs in intx mode.
So entry is not attached to a specific VF, entries are in a pool (like nic =
rq).

> > Intel CPU has 256 per core (per vcpu). So they are really a lot.
> > One needs to connect lot more devices to the cpu to run out of it.
> > So yes, I would like to try the command to fail.
>=20
> order of 128 functions then for a 1vcpu VM. You were previously talking a=
bout
> tends of 1000s of functions as justification for avoiding config space.
>=20
Will try.

>=20
> > > Do specific customers event use guests with msi-x disabled? Maybe no.
> > > Does anyone use virtio with msi-x disabled? Most likely yes.
> > I just feel that INTx emulation is extremely rare/narrow case of some
> applications that may never find its use on hw based devices.
>=20
> If we use a dedicated command for this, I guess devices can just avoid
> implementing the command if they do not feel like it?
>=20
I didn't follow. The guest device?
Do you mean guest driver?

> > A driver will be easily able to fail the call on INTx configuration fai=
ling the
> guest.
>=20
> There's no configuration - INTx is the default - and no way to fail grace=
fully for
> legacy. That is one of the things we should fix, at least hypervisor shou=
ld be able
> to detect failures.
For sure hypervisor can detect the failure on INTx configuration done by th=
e guest and fail the call for this config.

What we are discussing is not anything legacy specific, it applies to 1.x a=
s well sadly.
So, we don't need to mix INTx support with register emulation proposal, bet=
ter to handle in the follow up proposal itself.
I also have some patches to improve driver resiliency when guest is not inv=
olved to work without INTx.

And INTx can still work from system and device point of view, because INTx =
generation does not have function id in it.
Existing PCIe INTx can work if PCI PF device can trigger INTx for the VFs.
So eventq scheme is still optional and orthogonal to legacy.

I would like to discuss it separately outside of legacy proposal.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

