Return-Path: <virtio-dev-return-13013-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B9FEB64D8
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:28:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 83186E6946
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:28:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 78AF7986602
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:28:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6CBCA9865C1; Wed, 21 Jun 2023 19:28:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5645B9865BD;
	Wed, 21 Jun 2023 19:28:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpAMzdpKVt/VIeZbHIZCO4oBsQHHD1otH11IDi4vtcTacb+pIuvuMeRqemRVMqspJwoIJ1OqJNpemZqpPsYmsUW4u69950vI0G4b3vqcTdWuf9IIHLF09uBLsbc2zfM+YrS/SRvf7ur/kn8JpzXjRH5kbkTN1/FfRscUOTa4MiktL/2PZu4B6TjEn7uurTzkKrqNoB4svclNR75k+1ajSyGBFsDk7WvKLQo86Y54aOZI3zcq3pM9doUSnRBFNZe6n+w3H6Pio8FWsvxybQPhIUTan817RFVcof3KcljbI6bJhI2HT70Arr08x7yGyI6LtBJXv6D+OKWRhAMKLuWeeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXsnNZhru6dAqcYgPNAgkRNT/DDchmqfD4a9DSq9MbM=;
 b=b+6RcW/Qfj5DAr4E4YSpUrF7S5ELW9TViyCjw+ho0xBNy/kM4mlkDnf4XHA7xvQ3Mxzyg/0MUyBLODBaFZjaj7af/UXiD0LvvN2uXfKUmgX6wZf/cS8z8Qr7cJzwLcTg/OujnOhxaS/rX84U+WaMvIM+qPStg1WNhb80lnHz9RXnspTG71juqqEFWO7wsd3UkXm8JrGUZXYEO4LfsiovpM45Zava25hX398cV34FKLnVhSyj59zXk015KeI0PQLCPXMy5fPXKPINF0FPaa5c0LvhlqJaGgE3t79NgtuoYl1I0DT33Vzx/NAB3lSPENhrCemGnojrTQa4qlzYvkrdJw==
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
Thread-Index: AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAABD7EIAAG5MAgAAAR2A=
Date: Wed, 21 Jun 2023 19:28:33 +0000
Message-ID:
 <PH0PR12MB5481FDB711FBC0528822106FDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621135052.76028-1-hengqi@linux.alibaba.com>
 <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <PH0PR12MB54819746DF66F968E532195EDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621152451-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230621152451-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA0PR12MB4589:EE_
x-ms-office365-filtering-correlation-id: f793473e-79b9-4e78-897a-08db728db409
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bYz2CbjnvBvPUEcvAlQcpW4rUlLccvS6OmCCB3et4sW+qsjQn4JMS8k5rxIclZhz+THcv/78WzwPW/V9xpJbtAL72O7osbRwM+Nzp5uIKznmYRAQ2yJs5TLspiJQJVi5lqJv99Vy4Xkm0m+fgwjpjQUfQPs1srS8T7QCBwJQPbN9r4vep7HwwpJBftRPjHnHXhhEZ6eaVcKt26JNbT5P0v5YJoRR5RssGaCyx17vfg4R6Sy31wCFl3km+B+NKkzU8U8VvXlwaSG1MrZN8Q75rJvMKSK5YNjmvWzfd8F+ULSeJLcQ/p9lkLVfsLxs8WV2nBIw0K3IoXoVGvTJ5OLeXbUhiyjoO/ub0x/055Z+4WmYbhQx1ZAv6VZUFxs24mzK/Il9MwPHkWnmCz8ERGO5iYUwL/QR3ooAfZl73zzwQxmwCNCqB+HK35On8CBY0G2/52t6CG3o1OrCaEO6JE8AYe2HXeQvEemqJO+q8eU/0ptD3eA4jC6I+QMgtaHBkmbmodTph7KUMA65V5X6NiBRuYuToE3NR7ybRcXhhHbwRB2baC2PAAbmn4GRP4vC16DBcAmg6THsrdw+PG2F5zh3Sq6W39ZkcH2VaYBlV5PsMyZSTbrwZlshlfPN0dwmJMp0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(64756008)(33656002)(6916009)(5660300002)(52536014)(8676002)(41300700001)(66476007)(86362001)(8936002)(66556008)(66446008)(122000001)(4326008)(316002)(38100700002)(76116006)(55016003)(66946007)(478600001)(6506007)(2906002)(4744005)(186003)(9686003)(38070700005)(7696005)(54906003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SaS3fRzUeDxkk/t4PzgrvdgyTXR5IWWSLjqbisQY4epOK4cwHxUTwLThDKuO?=
 =?us-ascii?Q?XaQAOvGkHiW9vd1FmbasZCVP27+kr2rHzqJYMEsi317onGrSx7AHrq2DMl+V?=
 =?us-ascii?Q?FS9EUmsPwvnlzDqO/d77MTjf/oRmd7tmiZKd/k81AX9eNeLHHrSddY7FZv+J?=
 =?us-ascii?Q?esA0gigwPX3ZHFf7QzHebuhqstPMgMhzbm3X4HsW3LLZL+fNq0ajRmPWSAql?=
 =?us-ascii?Q?8RU4iGiUvwq/BFTHBx4wiil5GPTOilpmKQDbjJeRqkdsIWj08VJVBvJ8pcHw?=
 =?us-ascii?Q?/PV+QZ15YvKkpUVwk/pB6gy4uxQ0RMceOCQvlev8hkNVGJiKFLayWRXULhsb?=
 =?us-ascii?Q?p8ipeMR6fIwRQg/1/tt/tvst2AC/ADDG/RD5POR51L6oMjDBRXIcrS4y7vsG?=
 =?us-ascii?Q?GmaHc6WcRU8qFDmlBZiiXzESR8vzcvj0vjBlHpfBNvF1Xm8hNSewvfP3x7Vl?=
 =?us-ascii?Q?0MRDxF9RKKLyCqmdCOOaO9i1QeN05h3gBUIKrb2tRRsfO7olR+Kutxlxd8wQ?=
 =?us-ascii?Q?jlPWIiM7U9S6xF+LSvIBFhhR83XtaFwEMqG+O7mgFVTJ3MnsBk16II8Ocxzx?=
 =?us-ascii?Q?At6uiANdJ5kuEx23ToQ7NdOQnnqnIBtI9FMpDkjAuw4NdxcirOMT5FU4A0jd?=
 =?us-ascii?Q?vn9TGk0ce1jj+Jj5XQZk2YSisTWqmysFjOlyaVrYRfC1Z50Hs1q3aoX0nAhi?=
 =?us-ascii?Q?cJlDDSPHLqZjRwURIj/2l8ATylhEtNwqCTepZzBjKVGqzx8clhWUGUMeFRXW?=
 =?us-ascii?Q?GQwtnt1o1xEMgPRPLNb0vE7R/JNMbuTsyQDxdlVqg479Ah8s7hdYAQeI0BN2?=
 =?us-ascii?Q?MaQ9t91p+HdKmAYWV8TjdlV/gW797yc3/6WpKB8DUJe37YLU/iBU2DfBahWT?=
 =?us-ascii?Q?zEhtBpDV+6ObWDEER9YVN1lAE9iIngkEY2FgUefdu3D0rmZbXPKevZJTgp0D?=
 =?us-ascii?Q?GruKVZ7tyshmCyIY8dqCkDaaT7QAd/KBBp/c4xB7B8o5m0XOXIYTRf44sPWK?=
 =?us-ascii?Q?eqlXp2z1zJWFANWMAsYm8UJOy8YwghzkIipXtmIYV9YvIcnnNrTfXXgUYzew?=
 =?us-ascii?Q?QONrcA2ZOUkzc0F4VEJhkjWRcXESOsCArB7DLOkzlhn81aGL70Uy4ZwWWgHi?=
 =?us-ascii?Q?VpcdHtXnk5H2n5u79TtkRb9dCL1wqoOVeT3kjrNV/9ev849jfITFW7BoRlpG?=
 =?us-ascii?Q?7sfmCA8WIm7sFMY1Z4qQEu9OahlTDm+drjJPsrgrA5Hu6IEWNB+t4EUzuh6B?=
 =?us-ascii?Q?prziDCHHi3OAqZWwWdYAHt22W05+U0lbZMAYkudNwoKhNRq20sWc9gARW5sD?=
 =?us-ascii?Q?+nGuuAcUzbRydvyF5CHyloCpAmt9IOKliPd/K2RqWzmDFos9woMYuz0Q6rls?=
 =?us-ascii?Q?EER7xUFUnFL9PRO753imqRNLO2jFskS5DwwQsb5IdyIkCigOTig2XlHDZkUT?=
 =?us-ascii?Q?t/zTRwOJgj/Pr4W5cLvVy9A9I2JQaY9nQwl0AZ4pM7wqEr8awUhvtzEeHcMU?=
 =?us-ascii?Q?QpLS4p8VN/1Hh276XuHvrMR1h4Ujk4DIYtgXrIQkEQmgOef8NUrrf7SfVuri?=
 =?us-ascii?Q?22RVyFrcaSDKRz43Ik5iJRU9AGzS8sj9Repz1lHwHT/Vb7roDMTPSef5tqbY?=
 =?us-ascii?Q?tgnOTP/KkPwBiKmRbJRc7RM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f793473e-79b9-4e78-897a-08db728db409
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 19:28:33.9452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W1Lfs0SHM480jGCfuHhJ/JyIv23fbTtLSCfSvYjD9rn3Gga+9UdsVeDpGp+GHPAXmyfNmP11IYiXZz7WnPqirQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4589
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v18] virtio-net: support inner header
 hash



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, June 21, 2023 3:26 PM
>=20
> On Wed, Jun 21, 2023 at 05:52:28PM +0000, Parav Pandit wrote:
> >
> > > From: Heng Qi <hengqi@linux.alibaba.com>
> > > Sent: Wednesday, June 21, 2023 12:46 PM
> >
> >
> > > SET carries an additional 32 bits of information. But if you think
> > > this will make the overall structure more concise, I'm ok.
> > >
> > If it is placed in single structure than it needs to be reworded to rem=
ove WO
> or RO notion.
>=20
> Not really. all of structure is RO and WO.
>
For the device, what is the meaning of driver writing supported_tunnel_type=
s in SET command?
Ignore? It doesn't make sense to pass something to ignore.
Two structures are cleaner.
=20
> > This also requires additional sw to indicate dma attributes to be RW wh=
en
> mapping this area.
> > And extra text to indicate that supported_hash_tunnel_types to be ignor=
ed
> on set command.
> >
> > Two structures are more cleaner serving its purpose.
>=20
> No because all of structure is RO or WO.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

