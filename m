Return-Path: <virtio-dev-return-12359-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF367C77B61
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 15:15:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F215C29FD8
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 15:15:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EAD4B9865E2
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 15:15:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DEF9498635C; Mon, 24 Apr 2023 15:15:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CD78E98635B;
	Mon, 24 Apr 2023 15:15:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvuMIhyKEK/CupC92LDfKmVVEiprQ6GoUGffPUgK8iKi9r/bq7bJrAiZRMCDAylvW2aY9Q8TekxgFqNpjU90xJYA1S3ROlutq1pWiisgSKSX9WrV1H8qZZGJoZxPNMWKX2jUmBHVW5fa5nC2EW2sYU+gbR6nbzhGPYekdcqzXqVFu3g8vW/EIeR7OdV8pG2plK1EibyisJ8+qOQR4BexPfDkZHOoh7bLJH87ue2YOStEEDNqlzaa/CLsqWB1oFnLIFyRhrmfvQ6zOcNgV/Hv/+BPOW28RROzjIQFFraM9HySin3f1dqDPeNigFic2qocJm1iTk8Zwe1fG6gmcVV/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCVfnMWcSl8d4miiMUWrOsqUIIQmVA6oiy7RyQNmQ4E=;
 b=JtJyesvM63NAP5OoG7W8DYrUvztdUdo5o938fPH37FFmn3wjCmrl2l7z3D+5glcSTROTs0gAPFuQEXcR563bRdcWZW3ZCKMWD11z4MKN5uXCLKsP1udqghySQVJBJrs5rjNeWmxGCkr/U6wH2HSTmlg5J6u2fEGZYUaQOiBjwdMQ/XXzfSAlipac6l+cIdo/dbdyo7NMyZV438FACSvhV9tjzJxz9u7XeUitpjq33DSxcyqiC9Di29aHnUSq98UJTJqxiJsJrq8FibZkHWEvtegnrlNf2JpXVe8TzEvcjEbIaaw454req4h7NtgD6Rm/nMrElwuZUhhmhEQW4VALSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v3 0/2] transport-pci: msix register desc improve
Thread-Index: AQHZdGE6BcXrBONjlkOC0QSro05TaK83HJUAgAN5WOA=
Date: Mon, 24 Apr 2023 15:15:11 +0000
Message-ID:
 <PH0PR12MB54814D66357FCDAE3B3869DADC679@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230421145434.83774-1-parav@nvidia.com>
 <20230422061011-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230422061011-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6259:EE_
x-ms-office365-filtering-correlation-id: e0f67310-a6a7-4212-2302-08db44d6b2b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iK7lf4VmUqDjkHC4nX+CHZ82JK3wZupfoiFCS7LDjtvfnQqdSBF7ula9rrknNtbPAHhyXBqQ0HRhalfR1ovDKX1jPtxTBRgNB98Gd4OxOuNB955ASCNCPym3DlH3wfxtofWGo7xilt/mKKJs8tdAv5j9etkXQmTUKT4I6Rov90QfxWiH7PHDgGqBs7FJAPLO2ckHh0GnrMTyOzszuido5GDHrR2V9x2LwIUtE09Xtm0RHI+j2u6MhQ8A0GHo7U9Rl1e2lmVKoMIwhGk//v4Hn7CLTTA3eZ/viGBkRIvtyonm20xlvmWdWAgbONOEbubI57ZHX5RCOf0RRPBu/h84Jivyl2F949h453UsjM1pVcdfACrFSAHrWd3V6NKb/Bkl4KXfWW4NfAiDcd+Fb/MslIJsObYTSFdYilm8slx5DIlp6zYuTdF+yfXxs1GV4dllA7uLsmS+9Vaxvf+a37z0mBm/4lEnaCzxfhzkDiB6Krus63JLbrxBaJmti0kPRzuvkwH3JUd//C4R42cJYboJzRQj55WThwaMbqVr8Vf+8qlWxXxnVmpox7sjnwgGPdmyTS0F+wgjAYA7REiWN9err3sX00ZJw3ArBVhofCibAwHVMdjEuecmLRihrlguHMpQbUIld/YlbLtsuy1sTGD/4Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(38070700005)(4744005)(2906002)(5660300002)(26005)(6506007)(9686003)(122000001)(41300700001)(8936002)(8676002)(52536014)(38100700002)(316002)(66446008)(66476007)(64756008)(66556008)(66946007)(4326008)(76116006)(6916009)(186003)(966005)(54906003)(86362001)(33656002)(55016003)(478600001)(7696005)(71200400001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Qq9r44gtzJvX7fMUDazRIl6gpQuEBVkyj2vwpstPvga0682dwjzIzIabOUg9?=
 =?us-ascii?Q?dz8EScaorEzwdGEMsPF0olChr18olSdrTeAqEByXNJfi5IjYcxv/CF36eFYG?=
 =?us-ascii?Q?5vqNUi3agfFURL9Vq769dz0Zr8Na4jKrT7dh9uhJLdoYlUFQMPd/UYzue2+H?=
 =?us-ascii?Q?RfUWkbEQ+xQo/iZQ5shtwqvgyHqLN/IXhxlTqvlF8/+HCP9aqYuU50LV6dHw?=
 =?us-ascii?Q?SvbTjUQUnwQvHQ00I80DOeal0v/6MKq0qrm3DSBQJa7qVVaYBDHgXmIA42Dh?=
 =?us-ascii?Q?eTOqIpYPq2iXflktxskamBqtLnQMaThjh/3SJewSly2DWF0LmuQNIWNev9Qw?=
 =?us-ascii?Q?xrh/V8eu+kgRmoB7VgmAt5p1913oRdnNeowI8V6QRuUjdN1l2P2PWOFJcSe5?=
 =?us-ascii?Q?Yx8DS3ISAQhtKuXXGQDTawrq5+9ErYFd6z5KK+Q4HfCZTZ9g+P1Xt6wN/9fV?=
 =?us-ascii?Q?yK2WR+IO4+ejX9cgN+aGVSrUGPy/l53w+o/fennrICUZ4AlTH2Kf01EgutT0?=
 =?us-ascii?Q?Jczu1IuHXW5FcWIXLfiVkhvwz4dlI1OQvCTsi4tzxjVrXgjLtglIGaFCh3kE?=
 =?us-ascii?Q?r3UF3f80l743+6M3UVPaCCykqjoucStxsJ3rT2ErA8/EwcK3zEr1Culjt3vk?=
 =?us-ascii?Q?nzAOuD2I5UmFErfeUjqHC3OAcesdqTFLiwfcchcU7dAvxTX0vYLe5fS/cPHf?=
 =?us-ascii?Q?Yyicm1y+nY97PO2klD6LI+z8e81hY5Fnmw9O/2X1yNzcoKSnhLCItB6Lx+b6?=
 =?us-ascii?Q?cuR+KFyUHL7bAjJrKlJ/egUIJlMd9kjHZg4/gICC260KvGS+DOCIHwDRJrYb?=
 =?us-ascii?Q?9pGoiXRrZWCPyCA4FfKplBUgoZZKwJkkY5lMZ6w3S1q1fvXSIiBVUyeprLef?=
 =?us-ascii?Q?UmhzVKoP+BjobvsxTBPuoFEwNpPmTPoNL7L57HNwdGAir7YJGIOIoBFbeRoi?=
 =?us-ascii?Q?LcdMTAAAUgadXgmSME/EnH1bijQkCRhqqlmFs49UD99d73uTUJWLU3avWMxM?=
 =?us-ascii?Q?gk7CYGOgjkyIWONizdC81uWHednarOHJnotIzl2bDgu+vQ877HGiUOCYEZ61?=
 =?us-ascii?Q?3lCFaHgeRSKLkIZQ8DQ6zZSaSNtoRfCLVI4NWROX4QdSQJNOAXhzhm4uuOrU?=
 =?us-ascii?Q?q81BYsJJbbPaxewXfKpqV18q6CMYLye0WEIWDerO3ceM0xqT8sS4k4RmWGua?=
 =?us-ascii?Q?puGuL6kh2aOP04ppLP8ceO+tQ7rdUGwXhwVBKhNXY0aPbPRyy0prpIZh/lLZ?=
 =?us-ascii?Q?u9pHAKAez0+AOZh6ECPeLbDcODofsGXr1F2VwaMQCLosStf+eela131cq3B/?=
 =?us-ascii?Q?YnaT2hHY73pq93YpLbmaLKd/o+nNWBgY7NyIg/HqK8mgBlFYVHsAjim+PWSE?=
 =?us-ascii?Q?4x5Z2tv56ULXdbyV+wQP6IDNVq/jWmUs4ezumwkKlceufocl565UbP4Fo932?=
 =?us-ascii?Q?501TqQ+VLyA0Cgszqj9OHsEMYCKxKnnqNe9sjuJ6GqdgXHbu2MCgijqRM0Hu?=
 =?us-ascii?Q?rOfaOds1/OdZ73fzn+h1pCdGC2SEVWMGz/jVF6f70QNGHX25XSAAS9zz13yQ?=
 =?us-ascii?Q?KadrvaUehUmVgZ/X0Oc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f67310-a6a7-4212-2302-08db44d6b2b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 15:15:11.4423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: llsLU6eRmL+mYdSg3GkGkRtEfoEOIYQauc93tAG+Ej6h6CC67q2OkHkVO1oBSedVKMjLpuMNQCwcP4QBRDS4aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6259
Subject: [virtio-dev] RE: [PATCH v3 0/2] transport-pci: msix register desc improve


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Saturday, April 22, 2023 6:11 AM
>=20
> On Fri, Apr 21, 2023 at 05:54:32PM +0300, Parav Pandit wrote:
> > Problem:
> >
> > Current wording queue_msix_vector and config_msix_vector says "for
> > MSI-X", which is bit confusing.
> >
> > config_msix_vector and queue_msix_vector are the msix vector number
> > for configuration change and queue related interrupts.
> >
> > Hence, reword it.
>=20
> LGTM.
> Given the amount of back and forth, I guess we should vote.
>=20
Ok. created github at [1].
Will wait for few more days to ask for vote for any other review comments.

[1] https://github.com/oasis-tcs/virtio-spec/issues/169

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

