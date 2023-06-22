Return-Path: <virtio-dev-return-13050-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D841FEB64D8
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:15:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 48A2F15AA2A
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:15:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3E8559865EB
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:15:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 317149865D0; Thu, 22 Jun 2023 17:15:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F5019865D1;
	Thu, 22 Jun 2023 17:15:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odv+Vn5wumV8nE0SvqRYvFG7YUgD0fYaYC+9218GzM2SMxNNTaPRzTM/nhptFpabzhEMo8FgKM3zQwgQEYM7gh7J+VJ2LZqyTHV3QJLZpa+F6ysfzvl+D4yVUws1V5yIjVlJFnTzmd9GmFRpSCzywLDBngPXB+fgsJvkSTTzTZnHmTBoyxmAwLg6WQFNScnhSHDEK1ezIwvJU2bq1I7TxnADYWeieNV15L9l++x4tFmfbrte9704k/5iL8lBNCjWx3MNNbTumjbUbdoBd0gXVEkFRYB/D3wsoVP5/WOvViOMtNtn3Ur4BDJKZNbsVYt9riBKnfXvf93frD6bCi+qaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADlxcUaLFOODxXYagkGRmLZwLhaTy18yls9x8Lm2y/o=;
 b=bSJzRtPb/C0WVxoRdTrwQoAEh5Ny9a1TEhu1WEAzg77qQnnl5MCmXyFObjPcucWosTTWzjrJ3+o2gHFWIQLD8yxOM2b1zRtLKrVR+kbFV0lL6WO4ti/PqJaYbhiQy+2ScE/ELvIZaKeWhn0NNMiI4R+uOlsReVC2uizloIJdTNsY3qk92DXHcAZ4k/s3kjGcgKkk+VaS/M71UNvJmPLfkOQsp3IeAjcC5TH2Ufu/ilyRz9tFGFkb2mYDa9AcpSA91yS0QrLr+M9rQfd4OGBRYGh1mSBp9W6p5MokxPvzNuh7bNFfTrHtHbeeaX1cdmsJJGMpaV76hcOWfl/B9ExJtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
Thread-Topic: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash
Thread-Index:
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyAgAAMJYCAAAHeEIAABAeAgAAB1cCAAKHPAIAAY0PggABRroCAAAA20A==
Date: Thu, 22 Jun 2023 17:15:50 +0000
Message-ID:
 <PH0PR12MB5481367BAA5DE0BAA33DBAA8DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <20230621152559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481141E18AAF1BF214A0E29DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621161157-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C99B8504F02D39B3A6F0DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622130359-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230622130359-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY5PR12MB6179:EE_
x-ms-office365-filtering-correlation-id: 172ee895-3cb0-442d-ab90-08db734453e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fcfYKDo3htsSJbRrFFTAJFS5/2dM4n2Oxq5/G2k0Vz6QD/LXoUebSsZksF8AmJxuuKyx6dSGaBq4un+MSDUsppAruhoPxOddZjcSlvMrxrk91yL92Me7vmHmzLpsCkLoXb+TOddunuWGkCcAw9ZdBf3r3/2dI11MvpyUIV5l1sJmuIUw3OSU1OOPgh46fNtOBxXZ4N082IwX5It/Ot5o7f0UJytRaqIzRzU47t9Guiu64ayiqJ1TaS+uyphSwYavDx0QAPMZmiMTclhQDbjt0ZAhI/9VFIiRtk9/HnsDvv7BG2aHUmqtLDi0XGCy+kHA2Q0Nc3O1iXXkRc8RSM377ZMLy9nqvLCKIlxzTXXiIaBB1Tmvpn8liQYRJUOM/DMp9FyHTQJf8wfjU3etfjXhRWkpuOLiuTZ13xT4yxig8ehOWIGNQqqYc5VR+/OONOQ/bIyp1TpvTAHtBmpYdlSClAEO6k6X80Sj1Npp0oKgKXoiBGn/92g7a156+1jDL3RKfdWOzEfpDYk5otNtlciPquKXmipuHqL4eaZIeKDNfsWf3tKDNcehc1ntRlZAjt2iK5mBX/v2Fcz822dTgC4Byvm/iRU/uPd5+jHvQWqWlUbiuMFjmW34K+/TMbH/KYnU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(6506007)(38070700005)(26005)(9686003)(186003)(8676002)(33656002)(83380400001)(122000001)(38100700002)(478600001)(55016003)(66446008)(4326008)(66476007)(41300700001)(66946007)(76116006)(66556008)(64756008)(6916009)(52536014)(316002)(54906003)(8936002)(7696005)(86362001)(71200400001)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oO3yAX7mLuK9inD3XU0eeajKJ6Yq+91amxbMa0dTgJsOP78CsgcF87SHX6nn?=
 =?us-ascii?Q?IRXIutiP1YZSsgWXrlTUnGSSYfEu7mKuw1G6CJKPgIG9Y9jPjHmMJx05ApTQ?=
 =?us-ascii?Q?DXUw2rSM2n6iTdEN8uhkd2M5x0XkbXYIhzG36Xgvx32CxnKmy+rQh1A/qtNd?=
 =?us-ascii?Q?4pF+SjbuN15dxJPWJxb9/dfG1Huj27uNeg+2l+UDRbOuVZgAkivHE/qk7dlT?=
 =?us-ascii?Q?+i6gku/TiwERjSwql/LCV+qV/Oon0QmR0O7HoZi+hfNeMOvdzSLwsi9jGVUk?=
 =?us-ascii?Q?yLhUOQph4Num+6Hw3Cbv06/P20RuEJWaOML1zUajuPCW0ws0f2NGJDGAWo7Z?=
 =?us-ascii?Q?liHrGEjf6NfDMSvRUNFLhov2NAxO+fD0Qy3BLKO16XVMJhXWWE9nXFZqbTt8?=
 =?us-ascii?Q?3W9uxlRsWumnNZendJNnXyanlaatcF8Die0x+bbbxeRPlBeKzS3Uk1HrC0Xi?=
 =?us-ascii?Q?Wad2/SuGazzJf0lhF6RLKKbLaUEMazS+x+zf5cNs5RUU59qm0vfzWnJeF2gh?=
 =?us-ascii?Q?z0ZH341AsrgCerQ/3Fz/nzaP8MVL5UvP7XZZURxOsAMNnVxn6JhY+9p2XJG6?=
 =?us-ascii?Q?YDVrZIooa2d4HQ+zg2PnWrHyM/2h/8o3cc+5dt3yg10B65dMWPXYcrVTJOcR?=
 =?us-ascii?Q?xg5uqaMGQ+vLb1tgMSYxj/Ej2c27th0LXzGoi9NJqU5p0fnAxiTCqvW4LkC0?=
 =?us-ascii?Q?vWvu4FAq/h3wjOZvXTrmIA9x/9BlaC/NitK+gUpxxt6nfdWRJ4EQg6LpDqdP?=
 =?us-ascii?Q?G8GsJGILo5lUHEYvsSIBMtSjAfO6iCSSt8UxwU/ML6ALpPiuYGgqzqQ9KcoS?=
 =?us-ascii?Q?nSQfYD45rRlPFeToeDX6Ym0NKhcc4L4AZpX0DYvyfczFeia9NgwdwA+M9k46?=
 =?us-ascii?Q?O7t/f9MKqTiRwdQOzQm69zeaP0wkAJk9SQj0fu6Q3qjEEBvU7DEAq/i5K3rY?=
 =?us-ascii?Q?IFfbxbdTUle+MZYWWNoEsOuv/P2NAVXYs0DfckQS5rKIedDkatE4Q6/70PVx?=
 =?us-ascii?Q?1XUeG/6bbVEQIO1gBbLVtLsUBzxAVnHZMAmlrIHJ+0sfqzz1tyHPn/GMWjZ9?=
 =?us-ascii?Q?0YBTDNgl/EUMyLEdW1rOh14tUGapFe5Cg+vk0iqWEHlw3BbEVSS5XEj71z7f?=
 =?us-ascii?Q?WAhUmpa7UU6wSsWgA1MRPhCrQ/fl3F/RDY7uO7Eg3lZLZGsUBhF35ZCB/jyF?=
 =?us-ascii?Q?B+3UkqedXrczMI9BeZ6hVh0xbk/RVEaohCXn3o1aWp+OK0d7KLIIOBFoci1v?=
 =?us-ascii?Q?MwqM5tESq8SSYI54AEsRwF0XNBuB9oII9r+azTe3nZ63UdYzX/bxlIbr156Y?=
 =?us-ascii?Q?0I4UKClWl8hfsnN9/1Nk6e38QdOHA8sMrZXhJiFN7RlD76G3YDh0wZNsqfbA?=
 =?us-ascii?Q?5gOv0kncXDiqONRhVPAr7qIK6OgfGxG3nuGFmaHQzXmF8LagyZq2a70pfuLm?=
 =?us-ascii?Q?m1P+llaOYxAs5cHlxuS0TKitQOhF+6X4cbcELe4QExC+5pyyw8W4Zy/5fwjW?=
 =?us-ascii?Q?3S7oxb6/57pafRh8QdVj3RNSBBHpcplK12MsLgmF5ddo5kVSKt/oxL8jfSfe?=
 =?us-ascii?Q?HlnVUloSS7y2O+cWIRY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172ee895-3cb0-442d-ab90-08db734453e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 17:15:50.5838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xx1SV6cH779mucaJSY78T6jTXYXHQTnZ5I/X25rrBreJUrsmNxF4v/Ew+8VeEXsre+2OhscO90ySNPWF1fm5eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v18] virtio-net: support inner header
 hash



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 22, 2023 1:11 PM

> > Provisioning driver usually do not attach to the member device directly=
.
> > This requires device reset, followed by reaching _DRIVER stage, queryin=
g
> features etc and config area.
> > And unbinding it and second reset by member driver. Ugh.
> > Provisioning driver also needs to get the state or capabilities even wh=
en
> member driver is already attached.
> > So config space is not much a gain either.
>=20
> Actually it's RO so you *can* read it without any issues:

It is RO but not same across all devices.

> - block guest access to status
> - check DRIVER.
> If set:
> 	- read features, config
> If not set:
> 	- read features, config
> 	- reset
>=20
This is what I explained.
It is more messy if you equate to GET command has mess.
> I am not saying it is elegant but then all of vdpa pile of hacks is not e=
legant.
>=20
I don't want to comment for vdpa. But it is not part of the spec...

> And I am all for building something better but we didn't build it yet.

The proposal for 1.4 is literally very simple as below.
1. All existing fields of cfg space stays in cfg space
2. Any new capabilities to be queried, query using a vq (aq, cfgvq, whateve=
rvq).
3. Optionally existing fields can be queries over vq of #2

Once this arrive, no need for new GET commands.
Till that time, don't keep infinitely grow the cfg space.
Any next addition to cfg space, should work on defining the cfgvq.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

