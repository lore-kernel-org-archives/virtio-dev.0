Return-Path: <virtio-dev-return-12461-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69C1C77B7E
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:10:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0A3CF2A826
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:10:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EFA379866B1
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 04:10:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E32DF983E91; Fri, 28 Apr 2023 04:10:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D046998667E;
	Fri, 28 Apr 2023 04:10:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqYAHg1/i9HWi64J4lbkDdHl1JvPbX5YKm3UZ08URc/gBDD1Vs1DDkTtIYbeWds9ObPoHdofWC1Luk6rf8lYTTY6C9Txm45UL7csiXxFp//cE723xY2rPgHUvLx/Pxujz7N16zdroFPTRR3LdPCARbZUXlCrgQTG06U78yWgVnj+Wexe59uEUKytZEjxpG1OWNydzr5C3askNbZWL34oDhioB3bHE+mXm0+bb7xGK5EoGn0UrATGbWgar1SNoo9BU/mzvrOLsYJjbPqcu3SgD5RxZRJaNk7CFQD0LCwq42fl5b6mKPMzu0wwp0j6uI0QidNJNBWK4tU765nVHUSD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+WE28b8gyx8BAPnrqUSjjVaHZMqLI528FLhK+Y9H9c=;
 b=YJQJTmQrSpdFTBch/YRLS5KlZd6EVzNkoMM6IJpOF591qlnZ7F6QWNfAz90MIDtMkFmYGE4/1r8emOPXMzwSoHJ3vlQDzR/H+JpcgIusXXrDvHneGUbG35YfpjT05uzJbj9c/hnzHlSzYx1NQ0uJk7hiw+OlFUbm9iI3zCC0xZnKS4sCnB8AfbDUs0dEVrM5CiblEKYOfNpVpzv3KM5q9Ab/RyFLYSNhtwe6AkMSaDSYROjy843oahHRsdCHQ8nQDYCoehX5IXj+FbQXX2fBvKugnw6CH4QK49KbkmEMPcIrg8DNQdYc0GxsRMEErIUb4PEIyksyOwQNA1UzkG0DGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v3 0/2] transport-pci: msix register desc improve
Thread-Index: AQHZdGE6BcXrBONjlkOC0QSro05TaK83HJUAgAN5WOCABY/KsA==
Date: Fri, 28 Apr 2023 04:10:21 +0000
Message-ID:
 <DM8PR12MB54809734DCE2820CA728AFA0DC6B9@DM8PR12MB5480.namprd12.prod.outlook.com>
References: <20230421145434.83774-1-parav@nvidia.com>
 <20230422061011-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814D66357FCDAE3B3869DADC679@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB54814D66357FCDAE3B3869DADC679@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5480:EE_|CY8PR12MB8193:EE_
x-ms-office365-filtering-correlation-id: fb0abb8d-376c-487f-cb62-08db479e7c26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ROxx/lWvN63aHWoGVIGAVGibBGnGCq0is4pBVET1Ki91QfZTKtRWZ4t1g2Qxxl92gE+sZ2urdgIe9HeMnh7gR93P/Rt+ckXzNzY5CEyI3ehCII0q+1GGoChHvSGmZalab7TDLWpGQuJ8OPsuMM6UTmQY8Lq8JByLUkfMFGnJ+WMGCD+F3KVD9HIu3E7FSe4U6B/g3EPEy3SuI7qFxBEZHfkPrQSOD4LJ/kqvjqe24s+Uns1zDcstU3oltxqm2kfZcUIparMjgy7ugiRtlr2DmZ3wdgI3fFWndE3QOir197mXtH5VO1SvmrPc3oZLQ6xYvT0YHyl+KamWk1JkjwjR79bGxBDzvzIrAfxRf/1NAb6c5FGNGrxPHRdX4dpiNF+9wdAkkpy5FAansvgUc5XBh7FPrwMTCEck8iLMvmEMoXsPDzA2xj8D8I6g5gxbWy6+GiQQMsXB+0URwkpNCpwoc1MNffeRqy0HFbdV31rMWI5+KhhjsfNUerW9f96ZyVD9EWTvakP0OCBJLmAl5cV+bKUO6LL6U7lrJ62NXCAFNIta9K0tO7tmzuRVTqzX5zYu0lDuqTkSw2HgI87HHYNZWaK7ktkLJmJJotpG/ixPEXKLqxdVMlB19G421LuO8wMyGq3q0ZyrHpL7IqdoEHFHDw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199021)(71200400001)(478600001)(54906003)(186003)(110136005)(7696005)(38100700002)(66946007)(76116006)(66556008)(64756008)(66476007)(316002)(66446008)(4326008)(41300700001)(6506007)(9686003)(26005)(107886003)(86362001)(8936002)(8676002)(122000001)(33656002)(38070700005)(55016003)(4744005)(2906002)(52536014)(5660300002)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xbKvE9kGEUcY7l1zetkGafHtkKrG64W/H+yiLGcNPZSiBLyNDfuAtzlbevVT?=
 =?us-ascii?Q?gFKZzbWIyKqb+wbzTEYs4yd3v7HfkZsVXYZKxtDsZ5VebTxZnKGZa3wGjNnG?=
 =?us-ascii?Q?Hb/qjABcmFox0JhWFoMcCjiOYK0UoFx2Iitjk1bS5iwI5AN0t94qu6u4Yoa3?=
 =?us-ascii?Q?9OPafx+YX6aamAewgGeqeHbWr/iRraToAX3SEs7/fAnjoF4CmMAmXqGPaLhv?=
 =?us-ascii?Q?+7fPn6n5ERRPSb8/Ri72ghOdqb+pMw8jT7lDh40lnedaZy5xfmzpiw+CkCmN?=
 =?us-ascii?Q?8st0w5mN5MYSmz9KpODK+X8O8PU4ks3CItI33Kb7oE9GC8KKfpx6uCMYhNI3?=
 =?us-ascii?Q?EVpTNXyzzquL1JCyd+HqynUBC1eI5D8DARfZasleQ6Z5CHM4XdbWWy5gKAGK?=
 =?us-ascii?Q?6Jq92IWyab/9EvMDFYO5rFcXqFHhP11GEjybbo0vcr52VxQfY3Ia5g3hFuTx?=
 =?us-ascii?Q?hS5yKQHll2CL7hGqVsy0cVXK4A4r6ap+sUCSek8PZ5XYh+BnSPUi6lTk2BNt?=
 =?us-ascii?Q?T2ayND0Xix6mrTc0MJXDKf/FBMzSDYga9aIaX+jDBISHd5PHDmn7lJZYV/pR?=
 =?us-ascii?Q?4QW93MhULqtxXEH4k4NX8x3mze2Clg3UvYF+S9v+fQPpvk8hbYIHD57nyDyr?=
 =?us-ascii?Q?iLTDKq8a+ppLM32B16lz+/hKkw3iIXyCzqsQUwRZpLqE0irZRN2P/iNOgWrb?=
 =?us-ascii?Q?DwSq0vdA9jFnNs1BxY6ZIQY4pqAJUZ9GNFzXmJ6qsXUnTo9RJFtrVYMYtb+h?=
 =?us-ascii?Q?iamJNuCSdEL3b7cKEQWl1An0IZNgPTd4j2KKc+uAVC+ZUnXuyd5UfjeppIfM?=
 =?us-ascii?Q?Op8Hes+r6b1WSLhvG4II5aCqgddCjd+jLjMMKsK7HFZ7onQ9piUW4umiRqqv?=
 =?us-ascii?Q?R6rW3HXdoHkFFEOe/SswA6VUH8AZMqDdKAhmjl9phcJBFz6ditjkmo5jTv03?=
 =?us-ascii?Q?0NJ5IgzBBHDmoGogUrvdqJknsTz+FMdJLmDacChKBVp80z5V3rwNi5eUYOJW?=
 =?us-ascii?Q?uuvw3SWq/PgoiG6haJ+xRlg4Ff5BASttOvmZZE7ZZb8Xrifmb/C/owKvi9cg?=
 =?us-ascii?Q?2Ukl2wYqrI+3Yj9UB2/ehcDLJ8YbWuYTfzv53MvMU6D3T1P1eyEuS+aN7EHh?=
 =?us-ascii?Q?U0LnE30P0fyRcJ/yrLBAj8M5vFJorUOnpoekgDPe0Wy3rsq6B5Ffl7PzeHXT?=
 =?us-ascii?Q?x4UmpOvoXON8B5ihuMEFad0c5z6avnObNJMkHZ7Vvoi4boVnwwQcjLUI0UEv?=
 =?us-ascii?Q?0KAJJa0Ct0ETTGXb5qlRkmweBSD5A+pR+9aIAfpDvkYRjhfeOXeNhFNeQytI?=
 =?us-ascii?Q?A5beAPWv4/NmXtx1Ab2wzfFSFKU4FSNkKujG/I3n6f34/z8cT2XcLHq83waB?=
 =?us-ascii?Q?b4mB4kE6jEXuZhwKh+fhxKvufp3uTWhUWmT/viGUy0kL0q6vF6B5OqT/GtLp?=
 =?us-ascii?Q?eVc0Dw+6eDmRZ4FJqK0KTFAx0kOESINKcxcynti8LBSkbNpPJAERuzYGoutc?=
 =?us-ascii?Q?05M8igaFOAptHCOYLbNbl1RCGH3oX4xk0yRt4dRYrl0IYn3SMSBvhFmepn6O?=
 =?us-ascii?Q?feEGqBEGnZOdaSA2dJo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0abb8d-376c-487f-cb62-08db479e7c26
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 04:10:21.6230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMvJbz97FgAbWx69uuQ4fVKHZz8rAUtG0WSntvS2YQg4wZR7Q5IsqEbPq7XwapdW9/djnk5qQ7viFXSzKIUuLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193
Subject: [virtio-dev] RE: [PATCH v3 0/2] transport-pci: msix register desc improve

Hi,

> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Parav Pandit
> Sent: Monday, April 24, 2023 11:15 AM

> > LGTM.
> > Given the amount of back and forth, I guess we should vote.
> >
> Ok. created github at [1].
> Will wait for few more days to ask for vote for any other review comments=
.
>=20
> [1] https://github.com/oasis-tcs/virtio-spec/issues/169

Can you please raise the ballot for this?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

