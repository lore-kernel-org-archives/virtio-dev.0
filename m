Return-Path: <virtio-dev-return-12174-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A5CC77B6E
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:52:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9E7CD335C7
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:52:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 93310986549
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:52:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 878409841AB; Wed, 12 Apr 2023 04:52:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7752A986509;
	Wed, 12 Apr 2023 04:52:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzwAwTSvD9YKHrLwv4ZCCCumN/+tNolx5Z5x3VN0sXzlOWdOz0jTguP56Xm9mNAUb1eLpCIH9/BorUs70o/rT5otEmgGZEqf5ohQK1Ld71n3O7uyXAdvzN+RHbBzoc+HsPa+v715gq/ibV7MkFMJeOsC+CQYtIykL3GUKXxplxNkhC7wNtaGuGIYM2dqz++lmdi8jKn52vcHi9Y1Bs++Dhew8nkF+50S5WIH7jrswRKmm6+91JTwGaBjjfrG0Anl7IC0P0We5/2MIijLCx/p5sg8E2WksRI9kE54I+IOC0kRNbjqDDEgCWCR0yd3roRyArdNsN7LKjelJhIWFwOiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvY6F0a6f//lkcFOMVr4wDiFSVbTyJQikmz03SE1c/A=;
 b=RE387Xc9MvurdihJRTAjrCnkFu+xuLTqnaH+CM2xY1mZqehv7ImzjVyWStFyx+n1cwxaL5uL++h+t0op/pkwL+CkA/3Y/5RPuocKI2pxUDzr//breHMIVi/VnLMVqp/zSgFqOSwzyZtXIkS+fcr1+X0XKGOuv6PKbW+AfbgzeOY++LkVjxcTaINbCJrNixCdNwIX5muRQLr7lplsKxEDLqTauThiZdiKqf8Dv/HDmso7nd2QOEfVhQ1HFJuVZvZMETb8BZzJ6MFkFgQmRrmktkLvCDsAEtvg0IqOalz3Ly30VoIbM5MQq+6CUSCDByotCOGc835E7f0lmhJ17HocwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH 00/11] Introduce transitional mmr pci device
Thread-Index: AQHZY1tF5ObSeHDFk0eWHj0gIzL7fK8nLToAgAAAdXA=
Date: Wed, 12 Apr 2023 04:52:09 +0000
Message-ID:
 <PH0PR12MB5481EC4B82A0A57F08ABF3F7DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230412004331-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230412004331-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA3PR12MB7974:EE_
x-ms-office365-filtering-correlation-id: 559bb1b0-d8a9-407a-5d83-08db3b11ac5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nKnQz0GoffZuzEsM7aYG2BBaJs21Mu4zegUjYV+aJid4sI1fXUlkkEYwebtyJtF6nztJlqi9nUVxObDj67Jl4oInUue7nZZgpbfFnvnwTQ+jpbfHRN5F4ttpJV0F4SCUxXNyNYKyaB/VtZ9P9hMcdRYFTqs/mTMbNCqFkZOj+FGFPpJeaBX8S+M+6I4n16lXDos/UY6c8cK5OxkQPQmJ8kFgV8xU4IUqYo4x3iI0GvqEBki/HKqSWce6tJzFI2kFVPSFUJ9BC+gkv1N8zVuTXUxkBy3CfjmoG3jfBqzko0j6iCYRMJAIpPNTPrspWsNmgp3NPZmXpNnKrjwjhBn0aJZbtkU1kdLC7ypKqcb3zNWAzrzfZqPUI61ap102N3CabAbrb4sl0Aca+2s5SYYZwOmEmbkbr2mGcS3+jlR9xy7FRuYUZW4XoOsZNgeiKwBoWWlTqF1aYMce987ePFAUJrpUUYdJbLb38NuQqbo+ipz6G8FNwlgsdESZPS2XiMvnv3FC3LwDMH4fdT/oueHOOu6FeX1zaSTVWdYV0IZ+3XCfESitaz4YfHDtUvxUnvF3B2floMT5DlhY4lBroz9k1hbLtSsKtgno9LiPvLPlFPsFTvSPpyFQQwNmEZ1Fj3Bw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199021)(38070700005)(2906002)(4744005)(38100700002)(5660300002)(52536014)(55016003)(8936002)(8676002)(86362001)(9686003)(71200400001)(7696005)(6506007)(107886003)(83380400001)(54906003)(478600001)(122000001)(33656002)(186003)(66946007)(76116006)(41300700001)(66476007)(6916009)(4326008)(66446008)(64756008)(316002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4ys3bscRY/KelFzfJ2sRnRrpZYjfZtNwPS55iephuq/N/gQX30/JdL977TAb?=
 =?us-ascii?Q?It1YT0H3s8iVsz2LLkDxqePBiMX9c6ChK75QL4M+UwfNvL1vhSZrM/uHhfnO?=
 =?us-ascii?Q?A6pUHqLyNre+NpvfLB54hhbAuCaDKZyljKXB9Sd9NUMLFyFTZEbyNwGNQJEo?=
 =?us-ascii?Q?vTX+1Wj3KO6uXZqJQ0oxh7rbNrLZ54E0IlWvwY2W/Qk6XJ5nYNGjEaml3Zjr?=
 =?us-ascii?Q?KEVUA/0FQ272FUAvTJXqm5yjUSJAEOxkoiapqA+Z6T/Svj5jrlAR4s/iujfX?=
 =?us-ascii?Q?FOKARnnZ42zIjhYJCy6EZejkulcWPDkPi2O8CLREfF/hnXL0f2Y6rligyFrM?=
 =?us-ascii?Q?KuuFKUjpdmdoXVA6fwm/Mgi0rviVnh8FiDQD/NJVmIbSEdE661uf1/BgTZd4?=
 =?us-ascii?Q?mE6T02z/25pnotElzj9O7NGt0pv/Pv4TC28yQxNK0t7nxZ09W+/lyS1X6NQD?=
 =?us-ascii?Q?lsvnrl0m0Fz1eI/M3tiHkHVIcR3bFh4jAacbzoXR7zdD0cWInuPDw4ude1Qc?=
 =?us-ascii?Q?j7b9NnnbclZb/xSAJhnEWpk2XI8gea3KPlRKSlRy11xDsK44nBQggO+fR/15?=
 =?us-ascii?Q?dxKKReicW4vG4DcO4/VbbL8tzej5DhNCb82Plpm5oQfAb8vTY9Sp67lCXiqw?=
 =?us-ascii?Q?a8ugGHHwtlKOax9dl8GWBGLJnzx322Q5mLL6ArTZYm9IrXLZR5wuiit0fjH9?=
 =?us-ascii?Q?vtIWSfi63YJ3q7oUVMhqNCGiY2uCN4d4m3D1XQgo0iV06Iw5GXjfoOUbn+HQ?=
 =?us-ascii?Q?wq94TyJChiulgHTF51npx/fBwl7myCFXCd8u/Z/R8we2OcjendJwwJbWdxgQ?=
 =?us-ascii?Q?GH1H5K3iyBLUHu3rym6/VlQSnl5Xia6Tc0dVKRovZGCKaKE64wIydZChNRew?=
 =?us-ascii?Q?knXvgOcp9eVMZOtqbNIpETrcBnfuBnUajhIQOwBID86fBQ/K9D3tzJLmu8Vm?=
 =?us-ascii?Q?wIH6ljMEuzagSHKb1DfoOfnBk/6+HaKog5wl13YHAJ7PgstaJ7Gf1rxHgk9/?=
 =?us-ascii?Q?SMat82g3XjuXRS6Th/X3oWc5sEvIVcsrqGREYEjZzoc/Y5ncR4B1bikFz+E+?=
 =?us-ascii?Q?EKjAaCtLFQoeaahmAqBt3GNbp/38VZx2FxdGflIDRlwRrpp65fIJSPSQMAf1?=
 =?us-ascii?Q?65OybkKOVG2CG4ZbOOYlrHjbNHV4I3IfLivdK8LUfxwo0dJCRAbCbg2McnXQ?=
 =?us-ascii?Q?hqaLr4EZRE2R9UVzzAeBJ0rnCDnwvbDtOcC+S8ocNcAqwQNBXD9d8di42Frn?=
 =?us-ascii?Q?fLp8ryqjW7dYHE/QeVJciBBeYe8J937lsEXGdazgW1b7v64NNhMkksmfmxmB?=
 =?us-ascii?Q?PtchHAZB6BhHnkYZ7TMQNQCmE3cciGasJo9ofQjG/N+7JRbuSyH8fo4X0ZjW?=
 =?us-ascii?Q?FwVDqnol8yGEH+09Pk//MfAbQhPrayiInTO/H5PyLpoBwFney8xiFs8EjyRm?=
 =?us-ascii?Q?5TEyn/3Srmoi4RBm2qG0nidJjaXtBMiXp8cx7MQFdOXE21VnxU2qGd2y0z2C?=
 =?us-ascii?Q?1V7q+blHfebLhNGgeORGIxuKsc61IQhXj+RMgv0avWa0J6clqNajkcv6IHt3?=
 =?us-ascii?Q?Ng+ucwsM2FrGIA44ri3I1Sm/IzqoATy1dZu5ihlix6MEqwIVl8XY/nmC8VXQ?=
 =?us-ascii?Q?GPMVpW1p9+eTw2Io+XUoKEE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559bb1b0-d8a9-407a-5d83-08db3b11ac5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 04:52:09.4681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRmrG5Vg/wMB8Ntf3+2APxHb8BQUW2GO4EsoQaQ7o9o/JEME+C/+JzHJOeq+J9MN7HxxzOIAHnR8j36bClRIoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974
Subject: [virtio-dev] RE: [PATCH 00/11] Introduce transitional mmr pci device


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 12, 2023 12:48 AM

> Here is a counter proposal:
>=20
> #define VIRTIO_NET_F_LEGACY_HEADER  52      /* Use the legacy 10 byte
> header for all packets */
>=20
>=20
> Yes, sorry to say, you need to emulate legacy pci in software.
>=20
> With notification hacks, and reset hacks, and legacy interrupt hacks, and
> writeable mac ...  this thing best belongs in vdpa anyway.

What? I don't follow.
Suddenly you attribute everything as hack with least explanation.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

