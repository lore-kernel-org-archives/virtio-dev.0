Return-Path: <virtio-dev-return-11891-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BEAC76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 14:57:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B289CF92D0
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 14:57:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AEF8598659E
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 14:57:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A213C9863ED; Mon,  3 Apr 2023 14:57:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8E92E9863DD;
	Mon,  3 Apr 2023 14:57:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oArF27wnV44HHAwGci0UBVAybJEjdeePL0fC+5une9RXPM8YdEW+NVLG98hjcn0IzHt1Wyr2C7chQOdYA4vR+d2AOMYAw52RCods4wlzXkjW9CK98fgyzFSLNDNrA70JKkVYI/ZEKKQuO7vVQtwbPDsWgUtMKwHW7DL933STERY4Y8F0Wzgz93AgxPsWHSSlNl+wasO3886vUFnGOosQ5K6NsbXmF37Qwl6E3knVXesb3Q0JrFo8jMfTC+msKOSVOjEPAe2L9B/JKgz/ekuXDcQZVU0R9gWzVonZkmgse/kL/P2+9tkODXeDF3DWXqpoSBD8Qeb3gD0JRcLueFyWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnK36RCd5lsEGMVIyaT8TbB1PdiKoA3Dq49t7Wz9cSU=;
 b=AeKIbt09Ehpv4+453PrltR+7OVP38Nws0Xg86YmYswxdxE9iyrQ+FyH4KU51ZA6eAd5fD1WvBa0yh1qzS4/Cy3e921Yz9T5oSPJ4e/iMgh5jlCY9EVfNPo7g6zjJfzbCPJ4DX4QWAZ2dolOnuSPFl6w9/Tp4Eyni8gCdD3DAbDGYt0Bw8NPymcxd7ZVLo3syNc+Y+vbr4GvMJf2wJaM0cYQNLDzOV1ajc4+thQx/AYAktNWcdRVVCOiJ97t2BMUSEYg1cPfJprxV8r8OoTz8rs8ZtW+90UJ5v2P14wOygIVN6CWgq6Pidt1l+J5IJS5V/aQSbDKOM1dWJ9ViTIW+1g==
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
Thread-Index: AQHZY1tF5ObSeHDFk0eWHj0gIzL7fK8UdveAgAD15oCABER6gIAAAE0w
Date: Mon, 3 Apr 2023 14:57:26 +0000
Message-ID:
 <PH0PR12MB5481D50080A3A7C5F81E3F62DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230331024500-mutt-send-email-mst@kernel.org>
 <0dcd9907-4bb0-ef0d-678d-5bc8f0ded9ec@nvidia.com>
 <20230403105050-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230403105050-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|LV2PR12MB5751:EE_
x-ms-office365-filtering-correlation-id: 483e1ddb-bad8-45af-5f96-08db3453bd15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 j95QWFwoCAiAoImsbA6TE49SxGvuKiodP8q75FdC32Lsx16DMHr9zhzNzpjdpSvLgWXR3/d3gihy+970eJgrydFGrpPS09S7kylT01OerTnPHe3jBFJO00TS6oaorcHVPVWgJWmSOxRtS03/FdLKqWcsavQiTOi3wm1KhuDAWnBy0hR/K+y6RPe12bSezaPUDIImRUYjvoGor9mUnQvlUMYwF2YGZQyJAAEnapY9w2d4iP8ZInP4hS33IYI/OGVZYj6ZeoLbhNXFLHKYsQU4Dzr+YOzdzjmH04HkkjfNYFkkNrcis61PkONdB+ujzAoDOF/CI8YjgLfYCwuVu6isE0evnUhyxFkwHrP4342TWRRALepOBJEMvjPFqwX8B4T9w7YypX0zuK/FXR/U+USKKqodTZaZo/P45Zf1PywWcAajN4UkGgsPzex5EtuvrNzYg9xtue72nMh1KiLd/xECmBLD8AebEyIgDRk1jFsySpaZugzyHsV2MAIRA1PPzZ0rwSnNxDYG88VfsqSMGsFqE3qPvaA0+MkJrrENGYOG02w+INvly12J81S/1MP01sINjzb2KREz5uWgrdiRSk4apXb2hwtBJ1R8cVkOGAtUYWAOZijmKQVqW+VMbU884+xb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199021)(55016003)(8676002)(4326008)(66476007)(66446008)(64756008)(66556008)(478600001)(66946007)(6916009)(76116006)(316002)(54906003)(8936002)(5660300002)(38100700002)(122000001)(41300700001)(52536014)(186003)(7696005)(71200400001)(107886003)(9686003)(6506007)(86362001)(2906002)(33656002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9My1nPho8vrvAEhaP4ILfM5/0plGjF/BKfMQRoRyl2ULHXuO8Ur0hh4A0kio?=
 =?us-ascii?Q?pqmktnkTnVKy+pOGSo6cyfmiRFIcjv51ylr9F1C/zyB57dzjP4qAs3ak7lB6?=
 =?us-ascii?Q?xq8fBZ4mDfDLVxKi2Fp/z8C6GgJtNjDT5+Gm8Wfwej9U2PvvY9cCoLtAspXJ?=
 =?us-ascii?Q?uiNqjPSP3mELg/TEuPcXtduqGRLyKHMd6tnBaxsYnbXjk7YxxGr8iXVzMJJ5?=
 =?us-ascii?Q?PQZQCksTewjsVJeFP1A4sR5Iops06xgg8nnSFICNuNgN1tKh5yN8Py1cD66e?=
 =?us-ascii?Q?7BUywFhGMc3Yked8uwW5L5JaqoHySvHpIauym9IiFb2qwLsC3AkFzh+BehoK?=
 =?us-ascii?Q?TZbrrK+avggdxupcMH/iGoZbThVK0qkYE1/XTKccKOp7eDLfG9RNWa3UjI8T?=
 =?us-ascii?Q?eyyAnNcCl/8cFKgc2dFURQbgIq7pHGDkVX9TichPQpQHLXey30+Uqw/+fs4p?=
 =?us-ascii?Q?uFXPygXDn689Pv1nti3EDyZ+Dvw/nob7F/V7zgY9f29pBhSDuaaIzM88JotF?=
 =?us-ascii?Q?/pDTmo0luYVryP1lKogSu/5pJwdONCpnK5ouR5oOtt79Sf0vg3JqL68ITnDb?=
 =?us-ascii?Q?JvJvnAFk8StCkPVkFmqhqpHODWalTb9olSc7PM+7/2eOPlRCvc4XL6V0V+Vf?=
 =?us-ascii?Q?ZGxl73aA+L9sg817DUrljRKtsl7wcvxG8LAWcb/BlSXQIUCLZa5gxEtL/27M?=
 =?us-ascii?Q?ykJayFdtR+Q6wb18jdtLB841d8C8dfvlT4pRnX544j/3BmC+/5GiVguj3EZj?=
 =?us-ascii?Q?qFPVqq22+rrLuHVAltuoqtbBvjbhBZFtFLBVCn8hSKGe1W2k3FqNDsQzcx1n?=
 =?us-ascii?Q?D9DgB0M+1IlGyi762TLcwD3ttEujeXeF8j1IiPHmGMYpt28o9s34yehypv9W?=
 =?us-ascii?Q?Emi3lG87jPYJAWp7hO2UG/u+HtTYUmseSCXjfcOPtzIL7QlQjyy6cckCGGg3?=
 =?us-ascii?Q?iKmNEW6/y92mIxQ8Mh2CVWQFaqA3AR68ZXKoV/EoKzKUrAltzwwQnNsapAC1?=
 =?us-ascii?Q?aDrlAv9OON58ihBGQ6QtPCSKYcKDEYg5hVH2EX5Z33CxqnZnZltp5RmOLu28?=
 =?us-ascii?Q?WinizwnN9IzpgwXZtVdlPXPglBpcDy+j6yKXg14okzun9/Z53b0gJMSKvFPg?=
 =?us-ascii?Q?obCtEYA2ZsSzWzmsZZFXQRNfQkXdHlgIu1WqeY1Q/gxiyjBnCXuvBJdfWmoA?=
 =?us-ascii?Q?eLLFnWTgP0mabCs2DyiyRsI7xbzxZNY8YhqEYHzQi+SGNWQ8M1ISRZleKO45?=
 =?us-ascii?Q?IvK9AE4FU+doFDt/EJULoTTpGEQkUhIulvPq8w19gkw0Lll1P0hY/1VCJYD8?=
 =?us-ascii?Q?UmuzaU7ceemfs1JMCAKlZwjq8sIjT1hLo8BB4pgEMotNhn8mucQv4ObG4X1f?=
 =?us-ascii?Q?Zh2nGjz6Ncz8Y7BVPDEM8KQ4iO87js7sdrwxhVj1EHnR1uud8q/GBbB5APru?=
 =?us-ascii?Q?TMgKcJWaSVUVT041WlL8vz4KcXYw5LZHMN9Uf5qd4nzZRLHH7zCfgV9cZnOo?=
 =?us-ascii?Q?p0Qqbb9DIGqPzv/3AQp8CDoSurRboOkMdNJi5J+dtH5aUOWtwjKzmWiTd6KC?=
 =?us-ascii?Q?GR4q6EzX3oZyWbLyRXvZ6euu4lMHAJiJWhCbH/brMqqBaFfoT54FXkhO9V25?=
 =?us-ascii?Q?lzU43L22o2c0UEk4AzkQb+M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483e1ddb-bad8-45af-5f96-08db3453bd15
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 14:57:26.2182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dM/mWI2osq59xj60gK4F8TF88ujf55LeXHXnmtOPtdsloTMAc7i64iJw6Yz5XwHp8VvPU8PmV5/gyPTzwXAUpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
Subject: [virtio-dev] RE: [PATCH 00/11] Introduce transitional mmr pci device



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, April 3, 2023 10:53 AM
>=20
> On Fri, Mar 31, 2023 at 05:43:11PM -0400, Parav Pandit wrote:
> > > I can not say I thought about this
> > > deeply so maybe there's some problem, or maybe it's a worse approach
> > > - could you comment on this? It looks like this could be a smaller
> > > change, but maybe it isn't? Did you consider this option?
> >
> > We can possibly let both the options open for device vendors to impleme=
nt.
> >
> > Change wise transport VQ is fairly big addition for both hypervisor
> > driver and also for the device.
>=20
> OTOH it is presumably required for scalability anyway, no?
No.
Most new generation SIOV and SR-IOV devices operate without any para-virtua=
lization.

> And presumably it can all be done in firmware ...
> Is there actual hardware that can't implement transport vq but is going t=
o
> implement the mmr spec?
>=20
Nvidia and Marvell DPUs implement MMR spec.
Transport VQ has very high latency and DMA overheads for 2 to 4 bytes read/=
write.

And before discussing "why not that approach", lets finish reviewing "this =
approach" first.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

