Return-Path: <virtio-dev-return-11685-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1F9C6FD20
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 20:57:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 01FDA26A31
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 20:57:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E5262986460
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 20:57:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DA00498643E; Tue, 21 Mar 2023 20:57:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C6AC098643D;
	Tue, 21 Mar 2023 20:57:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlOPZvFKj1Isg8fcnrdzygByh40EdvzOj7nMppJVyN5Udwiw2w+zLG7zyA0aO2D/TRTSGYkVbZ84D2A6Qeo//ijVH7dvNRmFVUi2C1hXuo0RQE+U3p7UD2TAeCazlrsoz2FHuTPSgBRgE/V6RR9ZYuIcgv1/QpfI1+PU83T8ReI/8Wsk/iN0NHJ5T6PNCiHe/YIfg2dXHOIt3D1hYrYO1GgqoNYJZutMIOLC5ucPrUrTf7YolhjgSGGkMzg595svS13emANBfUL+0Kv4xVHk7Xshur4t1oU3t0akfNwbVU4Up54mqWScp7P7s2xmEHRV/lpRF5EvMLaLPT4pf+M13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mF877A+MAkT1/kWlT9TiLNJ/IILvSnx7D77bQ4LDZM=;
 b=jk9ijEA8FChG6B5oZpzL3nVwdak9jjMHVunKkYU4k+JD+PBMXQ6qhM/npf33ue1RXeXBHQpsgz6hnc5oJ6uQ5fEbNXl3Y5DXkqPtLiOyi9pmqIeeatNLKyG7zQ2lxKkwMnr4aKj5Vpnf2TjNYz2iThcxTBysZbZ47fpS/Twxu4cuPMqzE/Z+KjUpg3lYujZlrFoB1onkp1+pVWMpStomdW4m9Bs30kOANm6Udcn4uDSsnWqm5HyTOH7+bNhJE95GWUNnev3IG8PqBKfA1STfL/fi45X85RbKp6R7kzwf+UXMkCZo7UmxmoOFpmWL6Lg8fXOCVyqITSl3/c277wtwrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/7] Rename queue index to queue number
Thread-Index: AQHZW6sp4kTA0AyYcEW1xWsMt+tzxK8E8VMAgADGYXA=
Date: Tue, 21 Mar 2023 20:57:33 +0000
Message-ID:
 <PH0PR12MB5481F5DA833E3487C897695EDC819@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230321041036.201439-1-parav@nvidia.com>
 <20230321050119-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230321050119-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN2PR12MB4520:EE_
x-ms-office365-filtering-correlation-id: 963862e7-7712-450d-1040-08db2a4ee4d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 F80GKHsU/o2gyfyqvOaxM4xD3P0+BBJg2LSAOSvSncm9zZtPi/V/XlX6dhN44mu6BNG88cOLxNui2qWvw4Z8+LKRZmybefhxapU/s+Ux/1tEzozUVPu7zuEJrQCs8a1gKkwTJ4Chz0B789g28nqJr9rapJB01YWzy26IHFtJDXiK5kxYvzDNzKka9INIsn9y0U+62D9vwKgar3yN1zAg9zybjpf3X2Nt3i6v/935BltG2jvIxDK7fLom63IwD7Thh3Dq7zOVGWQZ1HljDLoRlhZTLfKo446PVAUe4hGhDMhNDeTHudIdWi4Qt9Fp9peB8TUZVzhgAi3gKT1Hme1jWihQ8Bf1b47P04J8efbJI3a6IFywzNJjo2LqM7lXqDa6GUeJuXGs97jHdjWtZHej/86/6T/Ki9V7ICc3bXNxpcPRf9UNvI7bT9M1RFzYlZGryyolQQOnvuT585Yy6qopoZtAsowDSAhkU1T2m4tTbibLZIaD7oL0SjkMfN0jdImjYb6i/LkwLVYD2WmqlI616l/EO4HwZWeD2F8MPq1/cprcTPD1C4paj74fggEJsFnxcKESit9yiUFa9f7D/PUG1EXcIFRG0iJQmh5+eQP1p9baUKuP7kM5GiKt4MGHF+sWjCVan17VvD/Xgsw4/B7o+ZiEtpTGJjIVDRVPioLE4Rf6WgbCWAm40HfqPvUof5Cze/cEbSoFwM/1E7tlgG1Wzt3dvabaMZBRKqjMLrPezezhAit3V+PvX7IolPx62Y78
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199018)(7696005)(71200400001)(186003)(966005)(4326008)(107886003)(478600001)(64756008)(316002)(66556008)(76116006)(6916009)(66476007)(66446008)(66946007)(54906003)(6506007)(26005)(9686003)(8676002)(41300700001)(52536014)(4744005)(5660300002)(122000001)(38100700002)(2906002)(55016003)(86362001)(38070700005)(33656002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NSBRPnkDPRr9pXOGyxPI53cBU7xzc6uKDe7614b76jt7fl5jAcqw4xxf8l9G?=
 =?us-ascii?Q?mFDUVSCMlnlUoq/MAbIkdlGN+e06/IJ0GeCz4r0HDBZbAkIelU0x+UDTObAN?=
 =?us-ascii?Q?O693PD9tZc4pZdaq7/JdXIzyStxC43B9ppe/SKLh2zuYcv0cxNlwNcvGRSaP?=
 =?us-ascii?Q?1pOhnHerTpp+y+pNbpJuEf1n4yeiuHJY+eRM8FosM5ImaxDsTgzbWBlMcjdw?=
 =?us-ascii?Q?6edMX8NRo/FQyiLt0zgEXl+DC0Nm4Sslwe3AspKwew+MAPSLIBmFeZqVu1Mb?=
 =?us-ascii?Q?XcEyWrby56yHK7FFeG9Ztf3f8sSUkzsI7WgBC+dtniXzXxu1NDfBbZSgPIA1?=
 =?us-ascii?Q?ySS8tjFU+MB4lW0EBpcQ+BwejSK4/g2dTNCyk300uj65NTDWVJrQLH2ZvGx1?=
 =?us-ascii?Q?eDvH+KLtPOOUORo7LvX9rbFl4gURlZNif6DeXSucbmVyld1S1MBpzX+4jJLK?=
 =?us-ascii?Q?b2Wfp7MbSXzoakqAvJDWOqTVUt5x8bDjBY2di0QXUl4PpZjwP1fHLQB7jtbK?=
 =?us-ascii?Q?OtpaH59IXMOdfsNJMoPCKk9q5vG/t0p/fPH+celPjP3YrJeUL+xkWH6XPIjj?=
 =?us-ascii?Q?MMQAhWD0K0HYma+SGOYM3LhjyqaLkF6Sv2a0+qn+DPbUTnzGdwI6my03ssPo?=
 =?us-ascii?Q?DJTFWsKRufcOBSNxf8WXSkq1APnsu4sMWF7/Jd6Sq7BimiHblT9nPuLxBecn?=
 =?us-ascii?Q?VdzzTg0Uruii2KQsn7cVKGvHWi5aq0u+bQHluClaFX9lGYOxOYCAD+b9sKoe?=
 =?us-ascii?Q?GuvDOCyKxdGT7CaX/vo+raGfcXVNs1mpNBOUYpr30RDdYEcJr4wvmrl1HrYb?=
 =?us-ascii?Q?yIhEuMrJPKNT2YNoc1kjJKRMyef9V9zCxeF63Dz5aUgZ2zVk8HpaGaNP9k5D?=
 =?us-ascii?Q?Wf4uGcudAv5+Q/P0cTUjxeuSoLzFJUf7d8OqcXF7txkOMkCy4xkQbHuEHwcP?=
 =?us-ascii?Q?G6Ucv6zTCJSoJBNXEnx9fm9d4qI/gVTahmaXUTkxzdyClwgIkXHDOWecO/LP?=
 =?us-ascii?Q?gxcXBz4GKe4k+nhysh9ZwTWSnTRNXy1n4bRVRVTxRB5hMhlV2bwRjVx1nKV+?=
 =?us-ascii?Q?Wdj54Jqy/+PPXQPQ6PeeoLzKY0SJpOpZJ0X2R349DglIPBhA7JYjRaAQk3mA?=
 =?us-ascii?Q?lPLLFR2YH08AoeniL3zQbvfSWFKxQ4qY5aqcZyuFFRmGDyn7qvDJIGYQQWNL?=
 =?us-ascii?Q?jbStOnDDxrQQNgN5ZVJizr5rmYRpNeigwrugESlejWDHN2rVv8kEM1hi4K8R?=
 =?us-ascii?Q?tpAN5V6eiET/UUAl59eo0JMHCUwDOShXScJ+tt9CgGOIrUUjXv4d7K5Rcpuq?=
 =?us-ascii?Q?5ybJfljJQyjcC2I9PhQjupPcY/fmmGWxIuHzMo663Xy+1GVZ2+jkNKK84k2k?=
 =?us-ascii?Q?9vFA2O8HF/yA+p3e3izn7L04pDCkNpdhOkPoIYEXW0D23NdsPR6honUEA2YL?=
 =?us-ascii?Q?OOl//2UNs9qU+mY8gLYsQLY3NMNuZUxXp4CdMLHGyCea0TCy/cxWhSbpZ4LP?=
 =?us-ascii?Q?fGQQGGvKuZNTls99IRDYprVZpCke5YQSiEaVNurObwc34MWGe/adXLTsiN9h?=
 =?us-ascii?Q?3QZOF+6FrD/egS/ywhc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963862e7-7712-450d-1040-08db2a4ee4d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 20:57:33.7925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQU0K4vuq6BoZu77CM2942LHJRDpNo45O2x58cIKySi12GngRrt5nhy1G9LquCNe6uZJo7VwNIiF23DagXn+dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4520
Subject: [virtio-dev] RE: [PATCH v2 0/7] Rename queue index to queue number

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, March 21, 2023 5:06 AM

[..]
> > [1] https://github.com/oasis-tcs/virtio-spec/issues/163
>=20
> OK overall but I feel this lacks a definition of what a virtqueue number =
is in
> some transport and device independent place.
> Maybe in the virtqueues chapter?
> Just "
> Each virtqueue is identified by a 0 based virtqueue number. Thus virtqueu=
es are
> numbered 0,1,2 and so on.
> "
>=20
> will do.

Ok. will do in v3 along with ccw change.
Thanks.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

