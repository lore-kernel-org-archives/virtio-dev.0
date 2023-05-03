Return-Path: <virtio-dev-return-12527-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3231C77B75
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 20:07:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F3B62C611F
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 20:07:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E338E9866DA
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 20:07:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D12C99866B8; Wed,  3 May 2023 20:07:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B868F9865A3;
	Wed,  3 May 2023 20:07:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1oskcb5thP/SKN6V0xfg/iQ6RJMPatTp9e9sQLeVt0sI+dqQ+SN66vcM4qgWMvjCsUyrXJ9YKeF755yOFkPLYobeZ4q7p1tAg+Xnf1i4sIDiquWOK27j9v7miHk9vyCko11+x+EJzuruSdfi29ao8nyQPfeBiNnAPPz8c1fgFCCcTQ0C8UmK4kaAPfFYZmLUk+t68E+5gDIOuhjbu8vKV/U7qyL9taF5TDXp8aR2OmkuP9tqGbaOwZhAgaSp1qZXocN95f9waeDaEUhNmjVBGNxeh/4tKxUmHfznwYp2IvNAxlsXm70qr0fouWyh+fO0qKyMFq3p6X9Yrka+kl6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bCnP8X9fhbhXfiKedlsYBEUMkc2w1nvdadhrw/qE5k=;
 b=N+h9Siz6GnlP4Olh77RZuT8SQktZOkw5AlP4b7MtNUSH07Umiec7KorXiew/U7Iy8QTSnseK4E7JN+I7nGDtV9GVD5JeNCnbULGsHn6Tyabpzgoxi3t7qYvMsqX2g/t2qpo8qZtWI4e4DjTtN0z2yg8PsKeXKBztZoxO5OeeKrqnchkEPoHDuDVrgkgW3A7qw3tTKSFH+ekikDMYClqhpuuRHL4QN57ZnqiN1E8sBW10WAatM9rpumwNbygy4cFm5/H+jJXXkWSWZXMCgpoTD6FBN2nxt8511JRKiPvd6od4k+QWyPy6PW20QUbvDj9BkJ8Oc6PLjuUoI7XWNqtw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: David Edmondson <david.edmondson@oracle.com>, "mst@redhat.com"
	<mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>
CC: "sgarzare@redhat.com" <sgarzare@redhat.com>, "pasic@linux.ibm.com"
	<pasic@linux.ibm.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH v15 10/11] virtio-net: Describe RSS
 using rss rq id
Thread-Index: AQHZeYjDvq8ZIIVYX02qnk9Xco2Cda9IvPYAgABFMLA=
Date: Wed, 3 May 2023 20:07:05 +0000
Message-ID:
 <PH0PR12MB548181AD43EEFA5CBD0FC967DC6C9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230428041949.411221-1-parav@nvidia.com>
 <20230428041949.411221-11-parav@nvidia.com> <m2fs8dv24f.fsf@oracle.com>
In-Reply-To: <m2fs8dv24f.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7372:EE_
x-ms-office365-filtering-correlation-id: bc348109-6749-47af-3eaa-08db4c11f78b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /qd7RdyopUEhCovpOunjA6tXa/w1pXqpwEmzmm96bjyTs3nN+AofOpFcSmXvr9znNh9WyNwXulRX+pvv6lQWfi0uspJKYUTXIhKHzDnEPLHplkkAz3aeAEOZqt6Pz2zh0jSRUs0Cn/RDdsYJyC+VA3lOc1bVt1+HnU6qiPzMz/psZiJXe8G4sIRfg0PYSxYZIX8nROfx8Do9QTY/iKQScyf3InbXxPpXm6wr+g7sIpU3/2MutUtzTvcCG94EJT7vyNv1nWnjhoe1rt0yTUV4hYsFlmKbpl/VR4WarF7SWjltKgL9NIW8P/cNFLaOaq3XWw/j05qW2Y7rWeqSW18oQcQaZ775kSAeN8rjm9DLadLeEbZA6h75l4ifuEHENoAct6sdITP4mTSWmlRGdsZkepr5h/qLs+BOODz4TcCJB8Su3blQRbedA+WoCOd/YTm8Ii1b/cb+j5SQoHqJTYwh27LZzfIyIzEE7/ceaCkDjWwxLPg8GlCAFJ2OEwibEgufWNsm+qQxU68djeweDNKJb7jixlySv8jEx//F759hjkt+m51VOU715qvFbn32y/rWad3MmGS3oy4UZEM/MthYg0giKsu+do4/ZWVGnUXRtPU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(33656002)(86362001)(54906003)(316002)(110136005)(4326008)(76116006)(66556008)(66446008)(66946007)(7696005)(66476007)(64756008)(71200400001)(478600001)(41300700001)(55016003)(2906002)(5660300002)(52536014)(8676002)(8936002)(4744005)(38070700005)(38100700002)(122000001)(186003)(107886003)(26005)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JPPjSUq6642Qdgyr9x13qIyiBOF1Yi2ntDndH9IvE7rJd3oKp3i1rXxy4lNI?=
 =?us-ascii?Q?+0arjMLLlkCvQkH6t1RbJxa+S8H3PeSM7e7RpDnjjsgIzOIS2FXTndkxvzAD?=
 =?us-ascii?Q?WQTn2cvR79ychOWFeFpCynaOuIdefW7rnDck7NB7IdBcyxP5eT7tYpQ5UpEo?=
 =?us-ascii?Q?NsxVtyxeddLrpPjvX0rxnUiJZnK1kzftMan1bgTSqU2XIo2u4JsT30y2zfLM?=
 =?us-ascii?Q?t+s2R3CcsBcj8MXsSRqaUPkAbzvz2KyY2HCkhb3ge+m5xiBqdW44eC8d6Elz?=
 =?us-ascii?Q?lomOffcGiL4iMYVS/RvH2mwggwxMfExNdLbgjS9aHCIbWO51q4/14AvnVB/O?=
 =?us-ascii?Q?9KNgs3lmb75nDZvkptL3YAbnR3dUQbYFqkQlgs6AseAblyHMH1PAARVFc1lx?=
 =?us-ascii?Q?7EUx5vnZ7SrYqgV0/MjVWsEKILmgJGihS+BEeo6NRbURsON5UcekCDUYa2/G?=
 =?us-ascii?Q?b8WuS2m3afr4f+SHOKYhFb1H1TIUZAam2kt0sV1MzTrrIDQa9LbXrnG4QwOB?=
 =?us-ascii?Q?auq/8Yk1driIGFZk6vlBfGiY84kegM/MeR+StbXxdu6SWFRzHN4MjhtHpeV7?=
 =?us-ascii?Q?sO2oI7EJYSd3IHM4/UVC8vhaWsTJyhTm5963zQUpn6XfvowXUNqMTIjD2uEw?=
 =?us-ascii?Q?hTkdMeCc//htcvWFZ7LI/zZ8qEEr/6hH8xfPM5qgyOIkU58vLTU9cQ/Uq2hr?=
 =?us-ascii?Q?J155KI2IO0Iw6UnFlb2vgwAizmTUziXSZ9WdYm/Oy98JtuE7VzrDig0CcMru?=
 =?us-ascii?Q?cAfOPi8iXxSJ83cAbYo661jaLLDYw78iDtN+TQmsIt03F1bdTSvrMlyRzLiK?=
 =?us-ascii?Q?NbXxz2ttx7vdXhnjUjLlRH8gxMdv2AFdoKWK8ef2UhQ8i3f0ZECS/MdJerDT?=
 =?us-ascii?Q?JKN0hYRKu0WCNY9ERNe+zT/Mx5SfS4i5k3QAHbgRTyF1T5+BAqskIkF6hinn?=
 =?us-ascii?Q?8gnrGxEmy3s0j7Zi6omo9EzWOHrEC1Gv6PZI4yDgwCoOOeSEySgkTzUxsKql?=
 =?us-ascii?Q?kypKi7rF5sEWbjbhTE6St/Zrfog3xc0/ptOD9clUmzTkQoTo+J11jp1S8jqj?=
 =?us-ascii?Q?WEB0Qs92TDjvAG3pLIdBk4gSuBpSFWysZB6iw0uobS+74NVA1SkVTEkblkiM?=
 =?us-ascii?Q?qcEJKkaeWqieNPu0b+iJopGqDjrzzdyPZ4go9F19voKA2cFEKNFRF6sOPvtW?=
 =?us-ascii?Q?ZqitFx/c9RKHHtr6hgXU0QXixn9A5r/drZrBc0pOc+/Xy7OM3KU264n30CVT?=
 =?us-ascii?Q?8Gy1BH2BcYD/8qGOalditXaJc0ORkXmtbJVU/dROolM5uVP7FhxkdcYxNh+U?=
 =?us-ascii?Q?LDn5lgqugMwjVO0bK031Ot4pw95nqeDI9FMpBOV1/U5Av97MJSKWpzbIKglA?=
 =?us-ascii?Q?9Gf561RgsOn4EQl6vuEZBQEF9BGEtPF321DNJznjzrUkJ/8LWKYwkzxiAkte?=
 =?us-ascii?Q?ZVQHyQKJLXOFrgKT3ZfKgHpQLhjAHmxne+dE2otkdwGwP1V3EemkjV+1NY3J?=
 =?us-ascii?Q?Wo3g08uzkIviwd7Mo/O11Y8/98oVJwfXkfeScXt7iQCqPhgA5j/oB6IDabK9?=
 =?us-ascii?Q?v0+snwSDbmban0r5BE8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc348109-6749-47af-3eaa-08db4c11f78b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 20:07:05.4263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sfEA1JYY4x9MHdqTvb1eKWM8/DgG0/WtarpCMLY9xlft9Y16+IQ9Qs1y2avdiGdOHvMeKpqBZnk/+eJXa6ebow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v15 10/11] virtio-net: Describe RSS using
 rss rq id


> From: David Edmondson <david.edmondson@oracle.com>
> Sent: Wednesday, May 3, 2023 11:58 AM

> > -Field \field{unclassified_queue} contains the 0-based index of -the
> > receive virtqueue to place unclassified packets in. Index 0 corresponds=
 to
> receiveq1.
> > +\field{rss_rq_id} is a receive virtqueue id. \field{vq_index_1_16}
> > +consists of bits 1 to 16 of a virtqueue index. For example, a
> > +\field{vq_index_1_16} value of 3 corresponds to virtqueue index 6,
> > +which maps to receiveq4.
> > +
> > +Field \field{unclassified_queue} specifies the receive virtqueue in
> > +which to place unclassified packets.
> >
> > -Field \field{indirection_table} contains an array of 0-based indices o=
f receive
> virtqueues. Index 0 corresponds to receiveq1.
> > +Field \field{indirection_table} is an array of receive virtqueues.
>=20
> ...an array of receive virtqueue ids.

Well I preferred this way, but ok, I remember probably Halil also had same/=
similar comment.
Will fix it.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

