Return-Path: <virtio-dev-return-13420-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70F0C001DC
	for <virtio-dev@archiver.kernel.org>; Mon, 31 Jul 2023 06:20:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2EB5529FCC
	for <virtio-dev@archiver.kernel.org>; Mon, 31 Jul 2023 06:20:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EB4AE9863EA
	for <virtio-dev@archiver.kernel.org>; Mon, 31 Jul 2023 06:20:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CB196983EBE; Mon, 31 Jul 2023 06:20:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 631D4986364;
	Mon, 31 Jul 2023 06:19:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdtY2Njnis8DuuWaLh4qgJNpDUVZicI4BbdU5H5etfPeTtaUGU/Ddt/xQa3gS+jyFyaMkVBz5jLZywcrX4NP+NjZ+tEK6N6aMBntmh0BKHeUt8zrGgGVGjx/7nxO7HQTLcWgoCQkQcbrcyL7h5G1IbSMz+BSZRF3nvysXbZ988kfXotOa6ixKJlwJXw5LS5kgwqmZy8Woli+7G41L1Rtt/UiO5jqhnMgcRyuAifLQCXcUn3J9xPGgV6IupPA4o5ZRVAOeAUY/5cTiZpb5k6eLbXv/Gnlk/jxxHsT2hpqoUcEZu7VZeN52CRILcWNGlox6N98zRcrtuaN/yIaxMIS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0nX1jSntHmezE3hHKxRe2U9h7ofbZ+Xn3ePhB6+3OY=;
 b=kY5rStNz5MKGhPOxQ8s9zgufQ/GmOHxUdORU4TTfuOOISGHt93H0YC9qBDnFQ45BLrzJ/cHhJQeeVR6JZ/OGrsLcg2AofHGJ3ZRH2zrj/AGJZZgAtQcu+x69OlGBC8KRo2yrZ593gJdExWoFU1iu0p90GS+sgFdpaCn/Q+SFOLZcKTdUo0u/5YobiJkMSVrtXP4CmC+MKdjGGj7mioNocsng9sn0OjjRPOfELX/F6iCiKu9QL9r6TByfCI+xP82GLKuGcBnjgegAX2wLUc/Vt5TNnWPRl/P7sAk0Vhn9WZqAY8uHoPX5tsfC6P2eatIcZGAYym3rKIbGbPkYb4wydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: RE: [PATCH v13] virtio-net: support device stats
Thread-Index: AQHZv5jvruUY/+MlM0y3MfS8bNE+OK/L5l8AgADzOgCABnXkwIAAFwwAgAAHz4A=
Date: Mon, 31 Jul 2023 06:19:14 +0000
Message-ID:
 <PH0PR12MB5481F2D5FA4BA77DD0A08192DC05A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230726081229.55947-1-xuanzhuo@linux.alibaba.com>
 <20230726070801-mutt-send-email-mst@kernel.org>
 <1690422490.8491526-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548149ED4C687913EDA3EED9DC05A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1690782610.3048255-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1690782610.3048255-3-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB8124:EE_
x-ms-office365-filtering-correlation-id: 1aaf1d45-5695-4811-12e7-08db918e104a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 flfXssjAyqHdlubH443SCLy8JQR+ciY9T82I5WxOpCNYe6vqeP7hHeNA1rlMhbksrBaT3buFHaTCgK2AfKNAv3mDoKnW8mOWTcrpCkFCjggyEj7d0OKgHyoG+pqfLGLg6BMTlY1cL9iUuLpZrOkNRHbJBMWNv3xbOtSe1Mu0en6pPKR0Sm9hMchLGmxl/uPEABCLmXboDj2iorgvauWa084ByH8orwnYGSVKpokXS+1mCR4IiDXoSYqKnqFuK8p7UtF/9pNAbnntlZ+7JnlO9W1ONJ9GMv7Oua6a7lkb/uiuSZ3E9Cy6IHHOVpIX3IKEZMbg5lxd2i4pxHtwuyym0/1dl1Z1pvvV+RwBG3Z86hGuhA0+jK4aoi2vX2EBZ5v44L1ZokPHYfjwUWQdm1mVvQ3qsZabRirJ/GM0eHLr/iLA5W5JOER5gcXKl82ItdjhpwH2Em7RJbqmqYhnqgYebPJn5vnKKaGOSHhAjMmGLCw9VzSQTCIn6n1ZBng3a0kOEQiifOpGDC7dj+M2WUecy4xn/+SeLaQNRugteMoD+6KWy1AwYKqPS1n3D5nNXst4s74fE3UsCyNAaiu/Qy8jSJQrxfIjkN1gaetPxZq7cvke2Bq7yAVevEVkbQXO19Nx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(9686003)(7696005)(55016003)(6506007)(26005)(186003)(33656002)(76116006)(66946007)(66556008)(52536014)(38070700005)(122000001)(54906003)(41300700001)(86362001)(66476007)(316002)(64756008)(66446008)(4326008)(5660300002)(6916009)(8936002)(8676002)(38100700002)(2906002)(71200400001)(478600001)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mAZoksJUBrmKQ7SkrvyR30NeKcQcL5vomkc5nidzApI0ygaSMSl1L6U3x+vB?=
 =?us-ascii?Q?mn/gwf79m6OO/vXsePj2MCV5NZTwRtxFf8k9Y1BEwgog3ILhYy7WJ5b+nQKa?=
 =?us-ascii?Q?H9NDOdtCMAzCzp3mJmy1DX+eQssonOZwRg6vYn7Jp5FkGOWjHfymyLm/cYVD?=
 =?us-ascii?Q?AS/Y3H5p+OWwpSnHkzZ/fyaqnP9hiRIsgq0oNewRBxQ1Q5UVWjMrLp6OCzGb?=
 =?us-ascii?Q?1QLhmLFUlZHOV6SdIdTEmDJYz7AqoQW5ss6NENT+FJ4vPqlPhtqZGSyqUL/A?=
 =?us-ascii?Q?bi+agQkDncTPOhggf796CwpeJLDOctqrGQza7mm5zsSc2w2IW0J6WZLaAFo8?=
 =?us-ascii?Q?EXnfwn0LCI0SiNTkDtJSNRdJCY8LCRw/CNIVbG1fst3NCPrbh44yUNzXR4dD?=
 =?us-ascii?Q?J7KKpVNOaUTiCeqjQomkhMMdgP/C3bCjpJMD1e3I+7u2GVPUA/FtBvAJGO/V?=
 =?us-ascii?Q?f9MWpOnE9mgRxVQayCeTQwqnqmsZ3ziUablMz8QTszMNEMNdz7XWTju+pdFo?=
 =?us-ascii?Q?fhzQETRpF7N1UixBeh1qCX9TawG+m+sL1yMncpqPZh1V0v60JBwDglvC0Ap2?=
 =?us-ascii?Q?pJhKgrOI9cYqznwgzQfHg1iebXyP8UfSMsjrC/r0qEPOYjJV/y6pMvBBkOL8?=
 =?us-ascii?Q?fta3pzyt0EMtixC9kiriTg9SRTNYsoVNaOjGJzee5SRg1rTmNkUn7jMRWj59?=
 =?us-ascii?Q?rlWygrpkWgLjNDRZ+/S73b33VEsY/VIYke5KKTipADgMlI8F10PZ7ACtYNuW?=
 =?us-ascii?Q?vytFdZfLU5FEFjN1BipkzQ1Wsd/wYQnXqtvlZEQuW5ZW1fcub17juE0SgsFD?=
 =?us-ascii?Q?qoXTMeaCvgdIgVbHukn53h8dnhfwWJ2jJ4sTyEV8NkYhnG3yuJqLAlztxN1h?=
 =?us-ascii?Q?d8jkbWCV+wgwj0cxRao9NrghkIR8FDSAeFc7M8vZY7tIvw8uqLAjNHJTcjoP?=
 =?us-ascii?Q?pmMBhg1U9XzPY4OZX3KeGKZLJBXJRGOKyiIald1ZD2yqppe96RXnNb3wSvaI?=
 =?us-ascii?Q?KQ696RYa9KrZY5hwK/DmVaN4tg4u+GaXTlXy0YbIDAcRDRjTe8cZT8VlcQHj?=
 =?us-ascii?Q?GYkWVNaOYcKSUzJpXVc1wjw5L5DaHRBnYu3rTkexdA1YkpzXDV3eM+9EXDCT?=
 =?us-ascii?Q?xG2itpMeTjD15ticVklvSXnxkmpYd7+Wl4F/6EY8J7V2kWylegq7ESUipxKe?=
 =?us-ascii?Q?3shG3bZ9+jTn59LdgckCyLAYAG+LM+OtBMioeYWFCdU5tesv2NF5gju5FrYb?=
 =?us-ascii?Q?PP1oMjODhw0AI1alFFlGM4d1gQa4petD7oohb+T6/cyOjlLr004FUWEj2hK3?=
 =?us-ascii?Q?FgychS1U3oR2AzPkYv6FI5P1G/0BgGzsYg4RWJq0Z2ltiQlNrMuSr+ut0z79?=
 =?us-ascii?Q?epfJ6Cc01UTv95kz2CLZf9aJcowcKT66wdvsHrFeJyLeuZmokr7WRdOUuSO9?=
 =?us-ascii?Q?kE5oZXuy1DXz/+wo8CJG/qT9BsUG0lICj8juAz4gfMLzxZrUTJNTNVJkHyo7?=
 =?us-ascii?Q?8rrP/a6zNP2eJolv+jttRcbFisP9AJxhfQiJ6CQ5IlmovHRH3Oq7cHVRBRnI?=
 =?us-ascii?Q?OUTKF/kTN1ALa4lW37M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaf1d45-5695-4811-12e7-08db918e104a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 06:19:14.7565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AmwG3d0PyADxuyMVDCDgRm36CztgfBRNtB3nwsjwxLtVY6s3Bo4ysr00JipxkHa0BdcPOz5d1YIgEy9g5dGnSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124
Subject: [virtio-dev] RE: RE: [PATCH v13] virtio-net: support device stats



> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Monday, July 31, 2023 11:20 AM
> I will keep pushing this, if your proposals affect this, I will fix it in=
 a furture
> version.

We need the bitmap indicating which counters supported which are not.
And those to be queried via dma interface.
So this counters proposal has direct dependency on dma interface to work fi=
rst.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

