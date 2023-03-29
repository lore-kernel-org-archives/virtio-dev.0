Return-Path: <virtio-dev-return-11837-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED2CC74A5B
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 12:59:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 92F37721E4
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 12:59:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8DAB19864E5
	for <virtio-dev@archiver.kernel.org>; Wed, 29 Mar 2023 12:59:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 84C329864BC; Wed, 29 Mar 2023 12:59:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 71A0A9864A4;
	Wed, 29 Mar 2023 12:59:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJtbPXskBzBJgeMK6Qi3j929xsYBiZTT0OlcXLGIXCs77mMxyTUxS4wy4FpFIpZnka9OTEEuQ6oWK4HpcYWp0b0qmcQsJ/KiIsNCrwP4JTngT1uWTMj4DZXn1lnXiWHY4wOrJM/n0IjPuM7tohI4B6OaFU1R8d43KVPbchXL4Jv9YhdFt8oE+qdFL6yZf8tPps/Eq1pNARo+jdCnfH2/+wSssPDpA7jSys1efxOlPrABXPCTT6XtiZ5NtWi+MQSFAMtS/pv2WrSy4IiruU4/JPmQ5KswGahvJqkyzdKBuv28B9QjrKBhKdacvYg9G1aeC6Ro6XEcQoWTTN7Lgm428A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwEWJstM1VxIuhybkcjwLwHG01/uZlTBHSmVdvG8G1Q=;
 b=i89u+qXMGra/ffNJlgblUiT9OPpH4i/zqYy4IEKtAKAKz1AIl5ba6oDWWuP2Ga5OI2yI5IS+xWzXQ7TZmD/EcHq9WI7ZcMMmOsmfgxN55XmI3JRjhvQMJbOUS1YFD7a3XVCt9nHBZvc1JCMxKQoFGP2S5rlkIFOSvgKAnYpEU//TKnCxQ3511VL0rk/YlBKmFT2a5jtvUHfCla8jAvYuxT07F3K05g8v46lwWhvCNv4xNRRVzJSQ8ROrwmjVVVd47qOrdQqEQeIT3FpiH5MAMNYBPH6LXJSzlCrVEDkbj9AJwBL7N4OGYz8CXrL2kkSB0Fa0mgcF0Db9PwC84OKJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>
CC: "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Thread-Topic: [PATCH v9 3/8] transport-mmio: Rename QueueNum register
Thread-Index: AQHZYbJ0Rb+N3x493U2ILNbzIztnhq8Req8AgAA9xSA=
Date: Wed, 29 Mar 2023 12:59:14 +0000
Message-ID:
 <PH0PR12MB5481430027FD045C5F78EFD9DC899@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230328201754.440974-1-parav@nvidia.com>
 <20230328201754.440974-4-parav@nvidia.com> <87tty3ncjj.fsf@redhat.com>
In-Reply-To: <87tty3ncjj.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7371:EE_
x-ms-office365-filtering-correlation-id: 134127ff-b5a4-418a-6b13-08db305565df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fQtfne7e6Pp07PyzR0Zsicmu87+3Xq2nLz+eHuubIblrgjOcu42m9Wc7woU4v7jm6dzPWo2EUhcF7XdcGe+btDgQJB1RpbMBxMEHxMee3cffo8ZK7JpWR0RmAISmusQlymmtQtGDvZaJo+CySFbOizKjQxGRR4SIUAQcLWzpyuY4TtcaC5E2dFuhyt9wuw3iZEZvyPfNQ0bOZ1Gaid213vAsYKmtw6xEQlZsQAihCde/piWxvPSr+gk+x+cdT/IoxZgD/0PJyTpXBuDLavflwMrkiBrX1H6ovI+3REm753pwKzbxXYqJj7VLmkJTa5XdVcg/t+NZSfoLhAlcIxJ4KbOzowbQpTb7iy8B9IlFf08amdgjlP/xOgCvds/G9Rfhb2M9lcz2UlLMwsgucagFiOk7Xocb2SAq55kXhkX24v39Obu0pYizpS8x43+p2fvx8W2CNAfFpwDXaCFhY7+LOpNwgbD6g5xBoORTSuWs3X3xCRlF/96KvsuX7V+vmgHW5ceskHcIHOAWJwRJS7TtJGUtYY7x0sidhUkzYOYSxPRZ5dMHjXipN/vyPCUxpVZAq9WcjVZ+8P8S1aSz0OY1H5Y5uwUCIVPwtn5kuNk+186nWeXu39cF3IReuIjOmZagbTGyx9s2ht3qltzuMaKciJECd2udIqgIOKNx1QrYzzY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199021)(4326008)(7696005)(71200400001)(55016003)(76116006)(66476007)(66446008)(64756008)(54906003)(66946007)(316002)(478600001)(8676002)(66556008)(38100700002)(2906002)(110136005)(186003)(4744005)(5660300002)(26005)(6506007)(33656002)(9686003)(38070700005)(122000001)(86362001)(41300700001)(966005)(107886003)(52536014)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KlV/nsxWCcRafkGFnS1ZFzVdYuE9pQWYztrMxQOG3zuGMYC34prH/e697ntj?=
 =?us-ascii?Q?FTKz7Ho7b+eKqOTu9BVgDQnhm1+XAnfAqgy7tsB00+7hfqDJ6bafO3xZb2/Q?=
 =?us-ascii?Q?RX1hR2P2IOdhO48UxMSzbEC6I1EylBS5VcJGb1ZoUSu97BBBH0SCHQ4DYQ4I?=
 =?us-ascii?Q?Dfum/4W9kkVtEN8Ts+BjPABRfuzC7P1t3JbTX1d4aTmWpKaTy/LF6VB5SfSc?=
 =?us-ascii?Q?Iq6f/cG3CZx9VfH2zXldDy7xDLj21mj37/DmgdF/etLxHsmIb2GerrADI+hw?=
 =?us-ascii?Q?XuBNd0cOlUvbQyfNs9GKWCzMn9JIikcEjUY0W7gsCBah87s0yUgJa2wy6q7V?=
 =?us-ascii?Q?ydnb+5ATU6r3JRubijtwjYCuIgNZKu0JDFqghAMy5Ep0oAh9QB1ycFeLYkz8?=
 =?us-ascii?Q?cLbJ8K6rtksPBSEDiNXNiH811PlAw9TGbid5s3sIT2fRwj/Z4HVKyp8rxm/K?=
 =?us-ascii?Q?U5SCQYc1hi+86l4g34U/E5SCOuxAm3TQshs2tODeHrGo5E5YqXxfSQIb98vU?=
 =?us-ascii?Q?tkqJTNfNTJYmeiB01g5oWOXkn9SdSH/lRPm3JPq8k/9pRuqO7gzyfGpejyRO?=
 =?us-ascii?Q?YoDUCNGENPEQ88ZpKqHscBnHPi01pLJJARReppJWfHTRXHlyY9LozUybyVEO?=
 =?us-ascii?Q?3bljWc4XY357CNb1WsGF9pfHA4yj8jNWQGbDe8djUN2zxKFa0InvZqK+719d?=
 =?us-ascii?Q?hJK+yq+d9YclWusNa2LPsoWXZfaRMcNgx0f0ZNYYwRMerk3nx6YqEm/9onu6?=
 =?us-ascii?Q?r5Q9rpwzb9dTUc2I07STG5zdXZArQBODVluLlQLBK2Qel8IMDCyNYLax1rO3?=
 =?us-ascii?Q?EaT9mI2Yhf6TGeF5Vp8ccP5aPQG5gvgSqHJ8eeMTEk7Mm6x6yfqoYyTWHTrY?=
 =?us-ascii?Q?L4C9xhR6UAzDDIdZEXU8MsSC1a5HCYJZkhfMJKKaIm2QzFcvJ0SPNoZWJ1gu?=
 =?us-ascii?Q?121M5DyJrQ5sQrHjaClDRok2HU32zCltIk4GCDN5eq3WX+v6DQ3cJVqJMML4?=
 =?us-ascii?Q?P7e5rQ8dqSaHEDLsiKf9H8C2RBydamoxswRM0VYbW5bllGiGYB50ecZZJpFr?=
 =?us-ascii?Q?1G0w2MInOwvXWn3e11YSQTiYwjM3xKM6yXGkmrBNv22i/gS51d+/PRkSmufi?=
 =?us-ascii?Q?gbNTXQ+ZQ6o4fVnLW2XT7HgmGugURFmv88PpZT1XIl6oi/L+MIID2TKuwpQW?=
 =?us-ascii?Q?Cs0ZobU/nM+HgSW8fjsZ8vynwgam84/GLuyX+bBFZJ62/xmLqiBrZWVH6QhB?=
 =?us-ascii?Q?aLysCjSnQeNKWJ9DQgNADGQMIhp8GGB0tBRm2xRyzvE2l1VdDBQjFvxdCQ+u?=
 =?us-ascii?Q?3oV9JTNiu9yhxfhP6jtbfdAZbJlWXFHPbO2O3fUrPAv68iLpF8JYo0wuQSfI?=
 =?us-ascii?Q?Lfh725YyxRJQjQ1J7jarqW11F8fl7rmrnTXpKdBH+EKxKUE3KUCyuItfAFg6?=
 =?us-ascii?Q?PdBgT6B3191tG1w2PbiaJiVfub/r89l/G239tl1iSRLPaeO5RZqQubeMBkQV?=
 =?us-ascii?Q?tae0Pm4AmE6KgH1exG92JlTW1fcWb/t10c/6tWgk/0IZSQOXz2I/p40arXFN?=
 =?us-ascii?Q?qr7AsLlIyyoCmpV/ThE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134127ff-b5a4-418a-6b13-08db305565df
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 12:59:14.2196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Yr1YuFMIgn3zdPlyeBRpcHAxubwHlHtVaQ4KPRPlI73Nh3FL5EerSJW+AGqOPX7RYS1GvIfy6V91piOzlyVpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371
Subject: [virtio-dev] RE: [PATCH v9 3/8] transport-mmio: Rename QueueNum register



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Wednesday, March 29, 2023 5:16 AM
>=20
> I'm not sure it is worthwile keeping the lines short so aggressively (aft=
er all, it
> does not affect the generated html/pdf), especially as it makes the diff =
a bit
> harder to read, but I don't have a strong objection to it.
>
I agree, 80 or 100 characters should be reasonable based on Linux kernel ex=
perience.

The short line requirement came from [1].
Shall I change [1] to 80 characters?

[1] https://github.com/oasis-tcs/virtio-spec/blob/b0414098602fbdb0bc5efa4ff=
06ea6cae8123ed4/_vimrc#L5

> On the whole,
>=20
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

