Return-Path: <virtio-dev-return-12441-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF685C7618E
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 18:18:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 078B02CADC
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 18:18:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 04248986681
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 18:18:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EC749986651; Wed, 26 Apr 2023 18:18:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D69A6986641;
	Wed, 26 Apr 2023 18:18:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gu2IopUlC3LLRs1c6JiheazlL3/SI48z1Jx+4syQL/7+V8LKfxwRN7aPAUxABRPBr9ZmVmJSEqMCFZoe8fufUMP5G86wGqReO1PsBNX32onNZFgPHuYC1MUp21Tf/rzfPGXqY3awA/dtjlKAQ0rGvy7Zvb/a7DxRdppgP1r55RV8gUl/pSSljEj0ce2qcoyirbVcJ+Zsq5am4imn9QHUIyEQImfd11HkazU5t30UKYtbpmkmdaCF+DdkZpK6pTOjnaL4CNtiJbxNcIuFqO3MCTCzy/FHyISoErC75+zYZJzAKEH5cesvKy3kun7AbfBdCbr5tvB2sGPeTdAVFOywiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5+fqJRD8Iu/n5HyOOg2bH8Crg/ysVI1xCxyQfHrDsA=;
 b=n55+lyrw1TSg2DczW8xHWzEDTvqs19EcCqI/iwsuMXf0x+PW33r/l9Fa4C++ROi/veeB956ptKNr2QpxOaprHB3yyJwwISi5SmrxGyvNuL3dgYcEuqZyzbWiIJXjEDZsEB/hWAE/XaSCKY6NCww7czFJ3/BX7k4tBK/JeaPKHQXGmIACItTSGC3uKt/kgS7xY+S4yzrr7bPSMxZ12FOrFE8JilBzld7unUtrdiGq2VnopjfDwGZttWeeDNouwKaKUYDZmlixcgoEfux9S25Po6W6NZfy5IvqhcyJYIWyLC7Eu9entdImgMtd+ZY8lho42Txoz/oYfsgSHo0WGBLzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com"
	<hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [virtio-comment] Re: [PATCH v12 03/10] admin: introduce group
 administration commands
Thread-Index:
 AQHZdswMuKG6jk+9I0m5FI6AWEnz/687YNgAgAAtfwCAAHQjIIAABG8AgAAAneCAAG1MgIAAAKcAgAANioCAAWT0oA==
Date: Wed, 26 Apr 2023 18:18:12 +0000
Message-ID:
 <PH0PR12MB548187F13419ABCEDCD8DF97DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1682354275.git.mst@redhat.com>
 <79c27bca6f72e4ea5d1d0e3a6b1a54369b03fb30.1682354275.git.mst@redhat.com>
 <e9256f17-f9ab-de6d-0377-d9fc210a7cc0@nvidia.com>
 <20230425020925-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D9A42176A43075D4AD4DDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230425092651-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BB7BCD1D9FF68395633BDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230425160346-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548102A2FD30A15994D6C0F5DC649@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230425162425-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230425162425-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH2PR12MB4247:EE_
x-ms-office365-filtering-correlation-id: 01038f29-1740-45e1-93f4-08db468298c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 F6vlSfxfmH/O/rTmHEBePb5NnCgXmzxqAY22cAu1wG40pUq68bfDPdODoTZpu4g8Wr9CzYa98l4o/uNkua7HkyKzLdQU8OQh4cltk4SVB++jidofC/qJwxOaCcaKnpWOKvo5lMKNac4urE9t01doPXt2QM46HDZSyYopnToow8xb0eKuHjZa4BUUyAVny+KK0qkVTB/LnNXaO5YrXkJkL2DvwaoIlCbOYLbw3R3m27UWOEY8rJQ9ixEKJ3sSvEGbLEXqMyoRNgttTjPqUE0rdlv7yqgJjClbA+sf+whZCHvRlbtoxI7FPsCsr8YdAo9ESj9dY6OaMixa5BFmiA7+56ME89XFhSIDDpT9j6xGkHPEdEHfbiaEEUt5tprdH3QiCjDjIcq4qbyfpJy625jHar22Oun1hOQ0pQV4uJfn3oVrjUyghqqLVA4UZsRIOmEer/KLBhalLORfofbzxGXxDzOefQilVGgJKL8B0OipICBYqmw0XPRJqUjwiarF4o+3UKlHwLx2HCBv3jfyFIN9IToFwtuX4zVvTA14pGaJWqjKCxqjY+ElbH8EO9Lbx03WzKBNYhBgPaTTgSKz1J2lveXTxyHsplwuEj2KtZh9umo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(54906003)(38070700005)(478600001)(33656002)(86362001)(38100700002)(122000001)(8676002)(7416002)(2906002)(8936002)(64756008)(6916009)(55016003)(4326008)(66446008)(66476007)(52536014)(66556008)(76116006)(66946007)(316002)(107886003)(5660300002)(186003)(26005)(6506007)(9686003)(41300700001)(83380400001)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MiyHIKVyaL98YVtxppiBj1Y12Cf/TJfEWl14Ow82FCSo6RaJBa4UJK+SyJR3?=
 =?us-ascii?Q?xAXvljJM6i+9n7dbr4iArhyLGLc747h7BSnAi8C9nUwprahyVKfCdwETnY4Y?=
 =?us-ascii?Q?Y26aIBZU0wUJ9z4AdhNWocyn4cGuoPweNrQineeha/fbosv41NwA7XTGDUBp?=
 =?us-ascii?Q?zKZ8DHmVEAhydCXQ/gVahaVt5FERoa052IjUVoe8DVuyXK2UsFqZkK6Uwio1?=
 =?us-ascii?Q?ZQCiWCR1EhydqA0FrULOqFoTiAFkmo5kebQYJoWf5AImqY7XPFQ4gSTKjCs4?=
 =?us-ascii?Q?6phUW8UraNQYeBFcNvGDSxOvbi2KHmMPvZjAKMInYDzebh6/qho9o858Qukc?=
 =?us-ascii?Q?3kjqwftbtWMO2AFJ6UX4lMHMGlOoZQ7UwfSJK4s2pN88BUaq1Wc+/Gb2LlDp?=
 =?us-ascii?Q?r4jKFwA5UpHduhEpiuO5c2N9jUhC2wCKOw9V5TnkgM2vF311+DeOrPZT9A57?=
 =?us-ascii?Q?/cOekYWZazYQsitENRJZ28MBULUKy7wcXDOICB97oyQBzJZv4du1GV+9Ngnp?=
 =?us-ascii?Q?9Mn5+DdGrSgVaRGzjTUNcAGSmZGXMn689j7ZFgHyqfi57FOehiLBTt1OjyeK?=
 =?us-ascii?Q?KJJlgPW9uwI2M3OEDjEOs0aaU4L8Kuso64majmeYVpW3jEPoFrcNqhdr1EIh?=
 =?us-ascii?Q?SrrldwZw9oDoJMRjC8QpHr2ndnEYR/A2M9bYXCkc2go+IRDU01Pw2GFBSlsj?=
 =?us-ascii?Q?kPaueB9fPoP6GJiIJXmjdxCR40/Sx7lvaoJ2fxya+RblJGXW5xsjAiyzC3yB?=
 =?us-ascii?Q?tBnJ/VeFgWhe6tKX3NKbnKd0Lf1p/DjAl8KT2M7cCG7K1mm1a3gJv9MUZihw?=
 =?us-ascii?Q?C5G+ObwCNP7+YgKsi9ju3ROvLwCHF1kZwvhCuiSRLNIqtBu1ml/s3QDk8wKE?=
 =?us-ascii?Q?2bWupKSjPrCf86T1GWJEPgkO28bc/47OrkoqwJqxCrF6Nwh132K2HlmCJ8XT?=
 =?us-ascii?Q?MH/NkcigRSDM32xIE1mQnUQWNSdtn9mBNRZHwVlki4S3WzO8KPKWf7V+/hwa?=
 =?us-ascii?Q?MQl3920X0S6iAI9Aw8SsHak2MABbq6OtSgtGYgeOGJfDgRDKOfarNP/TiM1r?=
 =?us-ascii?Q?veavH3/nKOPSt04fWj1jydbDJl4H1hGzY+94Na6Dkwh27U27wZ3+e7fQzH7z?=
 =?us-ascii?Q?LrDRkhsuUxWIX2nStnlNBnruBHwQI7Pbvz7RlNSs8XjMGj77G7bbD9SM4mU4?=
 =?us-ascii?Q?53tyZmzrQ7VobsM0WhNaGfMfudDEy9gzIkqyt41YXaG9g77+H14Gfmp5fGzh?=
 =?us-ascii?Q?FtUywQ8IzPx+bPSfD1stAqRDOIiBA7I1xSzcptrczqj2q87ZP01c+wZvsuQT?=
 =?us-ascii?Q?OMXv3OTgre5u9rArGHaRj8gSjwIUdroQEv8yZOIAfHVtX+3Uu6D209Wj0m5s?=
 =?us-ascii?Q?HJvY4s55DsGiAkGz7qVyyElSXT/ySh8QnCdWHKpowwrt0zXTKSRV7P0Uem4q?=
 =?us-ascii?Q?HyFJA6Z7DDkU7FHLmJ3pd95vDKeiERLxxhfDJfg9MxQ0DEjUS4oVm9wDhj2F?=
 =?us-ascii?Q?+/TpY0fhIOIKbe8Eb0vaguz0XYOqenxRpZzkk4NE9duuN0dLZwgLUM/6GiEg?=
 =?us-ascii?Q?wAWKQybX8Pa18KPXQsU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01038f29-1740-45e1-93f4-08db468298c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 18:18:12.5590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GEP4d+Mr8q6RgoCYdDuQWTGOaMJG63bhLCWgvb5ZL26dsC2Xgr2XO54XS72ovwLrahc5Ul7BSX8pao6laNEVWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v12 03/10] admin: introduce group
 administration commands

Hi Michael,

> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Michael S. Tsirkin

> I pushed the rebase to tag mst-admin-v13 on github.
>=20
> Don't have time for tweaks it's a holiday.
> I usually leave patches on list for a week or so.
> If no comments I will post v13 and we will roll a vote.

Please take below small fixes hunk to v13.
Without these fixes pdf generation script stops; on manual intervention gen=
erated new tables in pdf are not readable.

--- a/admin.tex
+++ b/admin.tex
@@ -109,7 +109,7 @@ \subsection{Group administration commands}\label{sec:Ba=
sic Facilities of a Virti
 \field{opcode} specifies the command. The valid
 values for \field{opcode} can be found in the following table:

-\begin{tabular}{|l|l|}
+\begin{tabularx}{\textwidth}{ |l||l|X| }
 \hline
 opcode & Name & Command Description \\
 \hline \hline
@@ -119,11 +119,11 @@ \subsection{Group administration commands}\label{sec:=
Basic Facilities of a Virti
 \hline
 0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a diffe=
rent structure)    \\
 \hline
-\end{tabular}
+\end{tabularx}

 The \field{group_type} specifies the group type identifier.
 The \field{group_member_id} specifies the member identifier within the gro=
up.
-See section \ref{sec:Introduction / Terminology / Device group}
+See section \ref{sec:Basic Facilities of a Virtio Device / Device groups}
 for the definition of the group type identifier and group member
 identifier.

@@ -155,7 +155,8 @@ \subsection{Group administration commands}\label{sec:Ba=
sic Facilities of a Virti
 is reserved and set to zero by the device.

 The following table describes possible \field{status_qualifier} values:
-\begin{tabular}{|l|l|l|}
+
+\begin{tabularx}{\textwidth}{ |l||l|X| }
 \hline
 Status & Name & Description \\
 \hline \hline
@@ -177,7 +178,7 @@ \subsection{Group administration commands}\label{sec:Ba=
sic Facilities of a Virti
 \hline
 0x08-0xFFFF   & -    & reserved for future use \\
 \hline
-\end{tabular}
+\end{tabularx}

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

