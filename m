Return-Path: <virtio-dev-return-13880-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B627BCE79CE
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 12:13:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1399342A83
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 12:13:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC8F498667B
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 12:13:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BCB6298666A; Wed, 20 Sep 2023 12:13:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AE32E98666B
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2023 12:13:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+P2+n4FGOmQnv2mJ6XUmxKRFd6woK8lj2buTw/rW0WzoAJxdxK1GztMgshamUc3at1u9h1/XfZGJWNc+3zMtqczxpXAGc+ESOac2ZyaMG8MCOhdWdKri2DgVWDUZ60gQSHvu46rmd4Q8k81H2zDlFElkNISvImOn+R66xH4aw7U/qmGNN5rL8HsZwxUtTT4KBz5P5FZY0gi54q+p+hh4V5WrLkSTksDvKmbFWNAh9Qwy2XeAXvPIHWSQfpJ07gHTEj94U9zUqD3N3mUMKwwnauxyZb/HmT3GMmUmEjWi+/0Pr2CXYMOUFgr6XKcMwqyWnwP8JCX/dkbv0ojIQ73Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxnABz1vI06qsLcOAAqYGnlikF5NsR5Kfpu8mGWbUOc=;
 b=m2bqx8TXd8Csta/6BX8BlfLZ21PTCLmRzQrl20FeLD2Xpsk0ajHjc3xr0OozqnU3BDl589DnRgILkovs8RG51wa30u+LWCCVfZWM3qly8o37Pcs8ksznmfcTJ/ij42si+tHJ1DFeC9Ura6B2lkYNKYsu7N52vhk3Vs3/s1zjIr078Z06IH8MI9gxZJITzbzXeLd/7RJzxyBUUgIbUXxZ6DZ7JzjfSxbybv/QTk2c3oh9ok0xGrgJzj22kPeQ5cRsO4G2184YI+0CsNERAcXyUK4J8Rwez6KJbbONXnhDL9Uy2ez61yI9y88ylrdXP8yvIe81qxtAhJQkxWEOpKE1Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, "Zhu, Lingshan"
	<lingshan.zhu@intel.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason
 Wang <jasowang@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAAM9QCAAAwSAIAAAcpQ
Date: Wed, 20 Sep 2023 12:13:50 +0000
Message-ID:
 <PH0PR12MB548106DF9E7B8F1857708A9ADCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230920075243-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB6751:EE_
x-ms-office365-filtering-correlation-id: 28c6008d-1e6c-4cb2-590b-08dbb9d30c79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RZAZkjTrvf5nisgLO1K+YGGAEcFowhye0gTGChhBykxIci4sxGfDxUp9WQlaAseTo14JBZ7u5HnaZF9wBOT8cL4fzRkKk5BFA3Y61xJE045ynoZflrFK7KkMJfqPh/Bz4xNzCX6CV7tLtmEiMBQ2Zj4bF7gcr3QB5ZuXEMdyl+zY2jrwdABz4v8Qh3qPs5BM++7I/EPIN80YraWXtdLQXhPKEH6RJ3OhYTw1Pzcfv33I01+RLXr4TsSOTYsvype2WOU99ke/E/PtioEDJadA1E8W3unZIxSGcABbmLJh1JDKE2qWAE4F4xj80XJC+/H+/Sp9e/t1T2cjZ4qorS3221PB3HUdwOgaAZ1MCP6AUaIh8AX0OL34Ung2GWVXiR36JWvtoSgbMwU3YbbGBTW+uYL/pB4zAMqvkt2dekxbrev9Mk1l5y7BhLsODMgzBGbz9O01bhVJ8EOxZSMn7nfqMrpXZoeUpyLc2a5ZV9Z01O8me+eUw0VCi3eIrMXG7mXs9+qGEoTc+Zmg6VOJK/sreyvhRlq+zHrpz6XTmFEkVf0T63/jdeI8Rt82oTZgCMz1Bj56RtvUordxrboP+dOpQ9AZXJiznKJRuTxfzWbMB+C6FDnRA5vGyY2tj5BqfAfC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(366004)(136003)(186009)(1800799009)(451199024)(9686003)(71200400001)(7696005)(6506007)(122000001)(86362001)(38100700002)(38070700005)(33656002)(26005)(4744005)(2906002)(55016003)(478600001)(83380400001)(52536014)(5660300002)(4326008)(8676002)(8936002)(66946007)(64756008)(66556008)(66476007)(110136005)(76116006)(66446008)(316002)(54906003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Al1qulMrVYPd5OxZ2goT7mtolfuWeLcHTnidJvZfSeuzzp+jLfjstrhOaEyn?=
 =?us-ascii?Q?8G5+wHrCNMNnY2K2V8yzPmbDvmf5Z1+imNRXwN//zfQrbn+hfZI937UeW9F+?=
 =?us-ascii?Q?q67wPY8m4P63ySHMx04eKQ6IDGk/NJ6WJ8o0fp/fVBs5aAG+bJg2JsTdEGIb?=
 =?us-ascii?Q?K1IbEyC/Rhf45QNgvXGuLFKoiywSBMVU4Ia7XQFJnnhJDagLy+ygNMYVXTw7?=
 =?us-ascii?Q?Ci1OGQcLTj/sBn7k/FqmEt2jU2gsQjqjq4Pv7aknw0968iKFTJze7rhrtbd7?=
 =?us-ascii?Q?8dc2/mB5NYKtNWc0f9lsScF9+TwHpVR/KpK83/gr5XxOzm4L3ijfFlwFcu9t?=
 =?us-ascii?Q?rNh6BQefO7m0GscClEAgjTnafZCK8IaQuo9CW7Q33B3u8AqetB9YbKmPq5q6?=
 =?us-ascii?Q?rtre4zfUCDOSFpoPxFp57HY8P+OAmzB0fjhPBC7AIU5vp8PZRnfRMDauC5NJ?=
 =?us-ascii?Q?LE/6CyM0UVQcCNwZUZmsrxWbIaEIPfXGwY2c3MufZWqg8tzxX39rrMkP8B0H?=
 =?us-ascii?Q?TdYGG7gBHgrlxtVmpaFmoM3xgdX5M7onbGbytDTpvcOaVe15gclCCP7I2mJj?=
 =?us-ascii?Q?RIDcqXiUDMU7XA3oDnOk+SUuhs6hIUIn6wc9QN8jDn4X087ZxfaOoxZCer1r?=
 =?us-ascii?Q?pnk7MFb1/EnRz0Dad2qBFs9a/3imasb8pUtV/YCZ0S9k2TlG86GM1tpFt5kL?=
 =?us-ascii?Q?R2SKEWDsIw8hpVVJMhq9c6+U5dRiNUJXw55lepj70fm5bDKkFn4SfJG2As4n?=
 =?us-ascii?Q?i9Oog1ghqbmJV+PhR1z3hiZUoprwZSjgcvPQcdHSveM3v4l6KIUvTPjzAICl?=
 =?us-ascii?Q?D9pX2UWzFeKaQyC95hB+D824aoxsgvPj9TEYZrbvVJl8kK8LAU7aR25I85Jr?=
 =?us-ascii?Q?a9kIrg4v3CwOcP4OxKwsjXq8B5XN5ms5kHmhUVDXqoDMUOFCIJLN/4qgAV2l?=
 =?us-ascii?Q?vSRohRxpmMJCYCG0RrObCL/VMnYvrFxncUt8KT3ZPDNNt25GmMjG7go8eEsX?=
 =?us-ascii?Q?BlvO3JiK66+J5VWXdHpuuC38QxRJcQ5guMjdMVQiEaI/gRYGeegrxKB1osYz?=
 =?us-ascii?Q?gmqUi8W/ovxj80oNauyPa56TLCK6ncUF+vXWYBbyfyhB0i1zuqG6QFamxP1H?=
 =?us-ascii?Q?wIZTe994OqsgZZ1BrWG5u1qZ6TmY7J8i1f/vEJwGFdCtzlW6OavitFf5foSa?=
 =?us-ascii?Q?jqAshaRm9V8KGdrDnZWO599U4q8RrNVmMCGV3e/75tOAIiRO0QtMops38cnF?=
 =?us-ascii?Q?0PO0IsJ03Y1tf5gShSQ7e54tTE/DFJPQipjqBZ/oo30uM/SsQebmaMV87Xgo?=
 =?us-ascii?Q?crKteVi6Nm3F8GBNEeHlFHJ5rhCGnAQil0IUtOTI/Ts3MsuZa4X8dWbRD4Th?=
 =?us-ascii?Q?6yWgQsRuwdXhkgeZD5RFKw2e9G/WbAgEFvmZNm5Z3VhA2ESvFEy3PMSY0oIj?=
 =?us-ascii?Q?5iqBSTptDk4tvp62S+mQi3n7e7Y0jKGcnZ/TindS1g5uM/o7aFFN6J8VB8Qn?=
 =?us-ascii?Q?yA0UfZb1QSVd2uVffjWbzR4gQw9vyREfTfWXCasOVME4X7bhaAgIreXqH7Ry?=
 =?us-ascii?Q?RbSMxnhBbgpPvgIZ7Ek=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c6008d-1e6c-4cb2-590b-08dbb9d30c79
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 12:13:50.0962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8fZjk+gCgXWrCkxehf0e1+9e8qvbm3mqemdEKE1zBKrIjFUzD8B9Cn0Bd60PRGPbjdnBhRAF3ghbpHz+4OOtMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, September 20, 2023 5:36 PM
>=20
> OK so we are ignoring TDISP applications for now? Everyone agrees on that=
?

We are actively considering TDISP applications to support in (unknown) futu=
re in a way that new spec additions for new features we do, does not block =
the future TDISP support.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

