Return-Path: <virtio-dev-return-12990-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73601EB64DA
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Jun 2023 00:14:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C78F87A1CB
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Jun 2023 00:14:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B866298650C
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Jun 2023 00:14:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ABF299863E1; Tue, 20 Jun 2023 00:14:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9379A9863BD;
	Tue, 20 Jun 2023 00:14:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZ5I9YoxO+V/5weQKLdJuEEWWDU9DPYEIaY+mhWx2WUEmRV0oqVenPm2XWthx8SIqdY6HHJ9d7+6Qc2fBndBpxzovInb933F7UAaM/05GSkEEKbzFV4BkCm3e4+8RqY8BozbHXpP5Fkm29uKiPSC/rYegw6zrCzkQZ36tu3JfdHmgD1LZx0fDpp9m9C2+ACmMY+Ofetcg3mdWBIUgIwXnVC6sqh/3WY9OPS50wLlhLzkAHuAYIT/zgwxo5tzkJIdAZ9lVhy2BJ9TOchgy7isiGGLWHpBbGwvfBBAAZC7nCSSefmSE3H+wPM7wqqKF1cKAUXtdKThlAYmpp7m89l1bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14fBv3hlv7WfVPYLCW1zU7eZ6e3mxs2ndVg80fZOk+k=;
 b=IM8VRfmr9ISeSl9idhVShzmIAUXdPV6Tr1K5ATnGSS9E5bTlUwlTMN2Htr+pVRhyRe93ehf+QVv7y1U2q5lilinvRkPf5j1CsylUn2GH0i5luf6bSXxUCWed6ysU1+zsYJSwTNxR3XwSdfgBrLyqbNAzTY/8XzdcpqHSApc+gjEefb7IIvTfQs5m0jg6TZpXg3lxpvIs/oCHIS9mRTnFQTvWTy3TMoVgGMuKsgJ9pH5UYvIYtMxe/g6bgYxTbzFiA4iEUTu0VcivpqZpSxU88oJr+EeptYhYNeKq7EDfA8KyFu/klGqwlP1gewahgPBG5dgwA9zFez6QSU7bdPZYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [virtio-dev] Re: [PATCH v6 4/4] transport-pci: Introduce group
 legacy group member config region access
Thread-Index:
 AQHZnhzOtKzAnSMZqEmlUO1lSJmuDq+SY/mAgAAAj+CAAAV7AIAAAUBggAAEYwCAAGkckA==
Date: Tue, 20 Jun 2023 00:14:16 +0000
Message-ID:
 <PH0PR12MB548155EE749082B769487988DC5CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619124042-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481506017B439B07FC1253DDC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619132018-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D7DD7654CF3B18939956DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619133754-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230619133754-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7788:EE_
x-ms-office365-filtering-correlation-id: 10a8f00f-5cbd-4122-ae08-08db7123493b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pEryK/BnLFPo4xZ8bILNQ4Ehr34p3yDTAgXSO1R3hQDYA8lxzX8NBZ8Ry6O9xBHMay+CjH8kAVkCMmmn/FuzVx+ugSoCF+O96bHRR+pTSiC1ytdJnLvnxyYPyl9OJwOxqiw76AWrodHerT2N4Q6DMbMZzZj+jvWQAPFcgFvLpZStHUB8jhbkBsBupRfyeVqBzMvvTLjKtN0Z04NdirEvT2su6QyfiqfODERPkudC+Kp+6A7neMRnloRJtPCKuKFcrVfkiG89Qu4cpYvXuZEeVA1io+gfNktj0DxZbB4xSeCbK6SJ0bDiRhxSqXkxBx++D5nhc3GGdCPe30YwJ+joYBoBCHfkO04Mfdgb09dNcOaqWrZLRKZDkvg67mgwxLBn1AXoqePA/JxLIJLuZfboRCBCg/ORWQuXLr5uPi8ZRBSTz7L8ajJDahNyechEwtv5GA18ZMDvK5N13Xaes5+sSC15kGD5nvodZOaN4sJTqQRkR0IRjrKXTYvyHQX9iWILYymeEuugUDJy58Mpr4EUDANBqDZm031REvJsJ4zukGJkpDLDpI5G+RbO/kxcYy311sYqe5XV1N7DS8Fu2ajeSOknIReKsdnXQsIFiAILAAgWFauJezEv78wAwxsjrfyE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199021)(186003)(8936002)(66946007)(8676002)(66556008)(64756008)(66446008)(66476007)(5660300002)(76116006)(54906003)(4326008)(71200400001)(7696005)(33656002)(316002)(38100700002)(478600001)(41300700001)(6506007)(9686003)(6916009)(55016003)(122000001)(107886003)(38070700005)(86362001)(4744005)(2906002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d4hvtvfLlXY+g+J3dIPVBpdabzNrZUE5tY0ZgcSQDuCnw9tODzWKwfT78czg?=
 =?us-ascii?Q?t2TaRQZVjDLJ68s/zdBtMhdilVbRFMUY6TLxwyKC5nJHPWvar+R1f4SRBmsX?=
 =?us-ascii?Q?vPuRV4NWkseHQQR/QOnHybQ5JKpL/YZJJNCZ8Ty4qnXOJEua4fdixjAEH2wT?=
 =?us-ascii?Q?UWRWIqjE9s+SnFg8MDwHtRpcdRhBZKQHFbPC6VKRC1wW/Bw21uuLG50kEROn?=
 =?us-ascii?Q?Hyig+w22tjgQSrOz7I9uCPXQEOaadSxfKwyaXfSbQY2ANqaHYg35tN/NyPRZ?=
 =?us-ascii?Q?0Sr8puqzTbzb1p2N9osD06mP/t07B8MvyxhlEjo0Zk4Suf6DagJYjvCcyUyX?=
 =?us-ascii?Q?Ci/Q5dkmQpqpuMSQsBtx9yEOE6GPtNhYrq7SG64D4DN3glnubYeJHgMIKKuw?=
 =?us-ascii?Q?y43ckdcHRvUuJC8Mn2/N+2x8zaeHOFnR3uquDfkqqkvRHFz82JzIUwDcirI7?=
 =?us-ascii?Q?A9Vu10zaxWt6/7zjjRjAlAbcEyPBDcbSf25VGIKQbgabnUIGsjqV5OS1LvdX?=
 =?us-ascii?Q?1XGZM1f7KCutzzp6+kxADDokRYeNTXUxUUsUvVFzLW5T0NnRNMrLqf/lg5Ph?=
 =?us-ascii?Q?MsUmHSWn61g9m/GtgP2+ebxVtNOLD7yTdDuLQpiEmrk1d1l0UOlBTnWTvGQV?=
 =?us-ascii?Q?NKUXpp6bvt2gp10ASAMYyeJsczLYg5xX1egW9CEz2qVm8PL0+QR8rYFLLVsN?=
 =?us-ascii?Q?GOiRqCrISfMffk2dJgQWdrMqix62OBWnVbHvoMt7tLbVUEIZ8Dr9X7ZBQ1i+?=
 =?us-ascii?Q?nfyxVapbCUNbvGR49uEiDRghTPHroOScHSgiiG9SShgfpKnt7nHm69mFJ9LE?=
 =?us-ascii?Q?IyGZ+f5kKgEboXekuYH+cuKgGjkA92eZrOx57EIafeKJHjvIqwnAV9PEXhdd?=
 =?us-ascii?Q?hFgJ37yvKcs0kjKsmXpWXmyMX3lujlnYL58O88SlpGFIeqfwbbztETFeN50I?=
 =?us-ascii?Q?PBw7jUu2lgP4/axg8Lf5HswGGViUDNWvvJKfsvpGtXxtwI9SJ0EHj1d2zgoJ?=
 =?us-ascii?Q?OM6O0WzZLtVZ59HGhOE8c2eqrN4j57FiRcgzyR2z0uBJYaRPTx5GEDY3E77I?=
 =?us-ascii?Q?/4+1nXBkszRTVJPZjUQuM02PkF3AxUq2Buj5FLqB8mnIwysbI0WL0VvHJBtr?=
 =?us-ascii?Q?YbXriOf0WRqFZFB/t1ld9ifww34LwSXMmtqkr1VTx039pQARxolJSvRc9rp3?=
 =?us-ascii?Q?wVomKpl59RF2SHuAe3VcQCbUp2UmwPgNLdgE3NF9dCeaUc3LLY1cH6CW5j+n?=
 =?us-ascii?Q?y/zlt07JYSPrkHdg5L/BLNrq/g+UkhmOL2h0FZoUCgI1UrvZBIlkXVdjdreJ?=
 =?us-ascii?Q?XUWZ5IBNMKpIJK78zkcALwrfI1nY8+Ce5wLvnLn4i1t/d+ekcqaAC9WDWtje?=
 =?us-ascii?Q?opVFcZXmpcZsagTBnGGzgV+pf2ObOSVYRfneK+whlbrPmJSlh3R90HPXciLK?=
 =?us-ascii?Q?vTBzqGpy4KEmx9W2Mt6rUG6Nk1vMsPWhR+t6bSVZ0Ve4HVUHnWReXFhitXeC?=
 =?us-ascii?Q?K6KkBAHFDZYLSm1e8BcqTZ6/uN1zS/qVK8LlNlGq5dtNfuHNl4F2XiZc9dtH?=
 =?us-ascii?Q?yKHCy8ZhAc7b/JrrYgDMNCFcAymDcKwMLX3Css6bipwhgBzki6F9MjnBhLyH?=
 =?us-ascii?Q?9FV12z47Bm9bkSb3J7S1+9s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a8f00f-5cbd-4122-ae08-08db7123493b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 00:14:16.9380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TdMkxihEGAPjVJNeANeKu6D+0Shnch71gWih6ELYFJLqEi/tdDaIk3ST71CswlnLDaf2zJlibb20VrYkzpWhxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788
Subject: RE: [virtio-dev] Re: [PATCH v6 4/4] transport-pci: Introduce group
 legacy group member config region access



> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> O=
n
> Behalf Of Michael S. Tsirkin
> Sent: Monday, June 19, 2023 1:46 PM

> These devices have a legacy interface yes?
Yes. partially.

> So they should be transitional to avoid breaking assumption.
>=20
>=20
> But they are not *exactly*
> in that they don't have a transitional device ID.
>=20
Right. They do not have transitional device ID.

> At least the device id section needs extra text then to explain this?
>
We don't modify any of the transitional device attributes.
In respective conformance section, it is described what requirements of leg=
acy interface to follow.

> Or do you just want to make them have transitional ID?
Don't want to do that.
Non transitional device id with the extension is just fine.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

