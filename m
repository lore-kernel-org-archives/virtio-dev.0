Return-Path: <virtio-dev-return-11375-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E9AC6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:38:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E66034256B
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:38:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E0B7D9866AF
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:38:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D5C3E986676; Thu,  2 Mar 2023 13:38:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C297F986674;
	Thu,  2 Mar 2023 13:38:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+SNaNOqWpYb+PN4vMySf5s32bJUr5ZsewH5jbdCV4xEp15yo7VxiJw1Fv0sdxSwdRsYuU7Zrw+hrRCkpspckdrJzKaGD1AQ3fwJc1USNOZ1XvEiiCXu7wRxxGRHQrzTBOmvRrKyuXDWj3jVzbN0zR2ihLEqMtq1FzRuN98JIvDhP7oksniYc3VXlt2NYHD/GHXYfSfcMnY5XW6syp336A1RsxgNLTgz6Gi/C2m6EnQQJOoRk+gjAs7Y+2LZ+UaelWvd7nQfB8GAs/xTr9Q8piYxqINzYImfkY/cw/+smeB2BKvIePUb5raT3mttY3L5eKCW0x0PEltxnmEo8eh9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKuFUUUupURISRHxFF2SQJo2Q/CkwWD7s4niDi+VSmM=;
 b=fC5n7cqhsAo355Jmx/sACcGVofpC84IbrdpCqgDDfXil0j2oSa4AM+s+q6prYIZ42mGAZEFzG7h6B0/A7Q2v8tqgBWpS1TgKJWm6WIz1m9PPT9sg0BR9pxqjlbJDjcxc0gnCNp7oIcCn1uvYXf+sleVxCzsM5gcPYn0xQtf/9ZfU91K20/eRWyunfjWmI6yzDHNZeWM9MNMDz1zFERQ7DRQTEN8eWYfhVcvYyGce+1pxGLoV3L+5nP2+kiQ4uQ1ToCRzja56uOwrIxVXVGq25fM7A+cJfGA1GP5EQq0zkXL7as77+ST5Ik0s9m6HOkEHp6WFDRAb3kF7mArMkS+5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com"
	<nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>
CC: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [PATCH v10 00/10] Introduce device group and device management
Thread-Index: AQHZTQeXLBm9R+Y8XE6rxgHYaBOlxa7nfh1g
Date: Thu, 2 Mar 2023 13:38:34 +0000
Message-ID:
 <PH0PR12MB548198D02534039E29796988DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
In-Reply-To: <cover.1677761896.git.mst@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB7007:EE_
x-ms-office365-filtering-correlation-id: 721cb7c5-b446-434e-b8bb-08db1b236b80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dnFGoBN/k8PP7xVZJb0T8mWtWOFVdwnfkmqqoFc+V3ufs0GqS0HubxR7yXjLJH8gGDUcB23+GYXkA9TSAhtHaEmh0c8I85oqePC/5duillMYK07ZDdIp7LLMp58ea1jxCNUH00yh8oaRAe3PgAJ3WSne+84iWUsmkDD6V/MCwzCj1JpwmopSrToXJzeEP8JixINnTPGnjZOoouTTogcZvcxZc/gY9r0aDbBnLBdM7K4BjeW0FoR319No9Nd9PsCgrumjCCz+K2O/BPIW3ucBeI+EkoKshf9b2v0oMrCfviXi1oIibiuFrVayDKA6bPRU7TciKdnpMCOYVHI7zhdbSWYBpmjqYHeaiFnu+C240GjAqueOb9d4UVXT4pBOBTI/4xLyrQUMdDFdAQberX7Ef1yggjWkrQNxtmn7iXOpUTCZPOqcHC8MxQUHM/3TXTvodTzipPoMxwoIZfbHpphBfcDGykEhImimI1tqXVQiZsYSvotoOwNwHytvdELBUGCi5jhJPe/CNuhK+ze6b+XbCWT9Sbpr/gQy9g0HL+WnWcQ4aAVryPNeBKDvkEuP+qFDoalNC+Th9ZjpsCheGwx8fWfqRqTq60jXV8Zk0wjZNokDdA5bcYAqHlN1IAxd/uPJIvo9ASJqT0WpZu/Ni5ih9bwc4K+q4HT8nVC/lJEi9bkPDJPkm6nBNEf4UmvXcP0uIx8OMhlV0Cv8YbUM3zwkvtLc6AFE4ROE5ES54IRRXMTq96AeKRPSmvFM7uC6xN8a
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199018)(38100700002)(122000001)(921005)(33656002)(558084003)(86362001)(38070700005)(41300700001)(66476007)(4326008)(66556008)(55016003)(2906002)(7416002)(66946007)(8936002)(64756008)(8676002)(5660300002)(66446008)(76116006)(9686003)(186003)(6506007)(26005)(110136005)(478600001)(316002)(71200400001)(52536014)(7696005)(966005)(54906003)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+SXeiPRPXvP6Zs1f5fFeqCqt7rHM8BbOrCQ6EzDaKtLg1C+1PB+11TDGUAIK?=
 =?us-ascii?Q?a2jLX3Rwi/8p5uQaXbvpxQLE1lGpE/A5xejE9EfbLjvWBZrfmQoUwavf4oqG?=
 =?us-ascii?Q?BnFVqoSRYwlVCjFFLdI+hsy1o3o/Ejn8AG+KNv934NMdrdecZiTlMgP6/dgA?=
 =?us-ascii?Q?mNC1KIfakS/A8GfV9dAo40/T6sj8a7FUocvvHHBVag0yUTbelX4G19XgHBBR?=
 =?us-ascii?Q?qw/J78lVrQkat5yuWNASYDUkEMX60mxCjfe3rGH/BFaHs1KcDCW4mVfAw1Vl?=
 =?us-ascii?Q?G/IxfK7GbCJs5iK1l9fbI2EM87cTec7WdjeNGPXp30s18HMTQU3Duy5mfHW7?=
 =?us-ascii?Q?U0/nHA272jZySQvLg35IFu0zSSwByqK2LpC6QiysS/4PURcJHEXRvu18ixPD?=
 =?us-ascii?Q?FgYmkOTAmIU7ETH7oxArfYgMn6MkIwBIhADd85+0TQKylB2J2j9IapTV31ZT?=
 =?us-ascii?Q?TLkg/P8AhCxm9y7BPuleHsoMg/A+SXmNc9Ihe9NcnAGfaHsNEOwBxfMYymXb?=
 =?us-ascii?Q?sCz0osS84aH0QgGpk2aJpNEDodKzaWzPDg3m4PtiGDX6J0EiEUBbsMRgW9GH?=
 =?us-ascii?Q?O3ejcSOGFqo8kx0JwTGB0iXQzXnbsTI/TbKN8PWdgq2ucyEqhtZZ6nazYRgg?=
 =?us-ascii?Q?Us+tZvcS0tnHrvE8ZkfobjyncjjAdaYUu+8tsBMotzPfJoqN+IDSMeYp1W1+?=
 =?us-ascii?Q?hDAIXQZSUHkqRIvOKydNZYwb29YzZX50NAzdXLT2Qd7xcj5p8yFN+mJz2sjq?=
 =?us-ascii?Q?NZnXgDXw3gz1FT4UpD0ZVSvvLfrWYS2jcyiC0Co+xtOuT9wX/+qUQKWYtrZt?=
 =?us-ascii?Q?gZGauFD4rXjxyPZx/46YTsvXJG4j+J2Nq1yadioHumpa34bLn72qnnRwQ1A8?=
 =?us-ascii?Q?wmD1pRCyS9NsFfHC9Ytq3a/+WqodX21GjvbGGBAsPvlB4pZ4kx+GgyXSRF8x?=
 =?us-ascii?Q?Cw9wVPhq14ecWmGJtqt2AftnsPqK1/JDONb2ZHwADavd2ddw6SCgqbHjy69E?=
 =?us-ascii?Q?YUmjTG08doAQ4jomKXMVxNSZ0QXWSESqKAfOzGvqPXoh6xCsiYlO6sIkU1a/?=
 =?us-ascii?Q?wdPtIxTpKtVr9QWuZfA4oiq81IuqCWXxQaS4Z9YKXKaocthhiZk028rmvwnw?=
 =?us-ascii?Q?+kgFDMb58+imCrIjLo9dZvwTDidiy90KArixCFND6OW08rs3E974dRhMVuZC?=
 =?us-ascii?Q?/d+iJrtN93/jlKENEAS3sGgFTCBTyrYtuCbSnhKq194Ufqd8htG/UAYIFyWo?=
 =?us-ascii?Q?J4afh802NrauhuXehGl2v/LfMmlPXlTlGEzmuGYo1rJHX1VsNzX4ZAW5dgfi?=
 =?us-ascii?Q?xkRY+Em0gG9J18n5COwQN/W9WNbrrHXTt9T/2gjDrsoFzvo1sEbYjbDkhs2R?=
 =?us-ascii?Q?gYV5f3I7yQC+HvI3o07CR0MYX0DLiwl5809fC3CZdug07Adc/p7V8htlG4NW?=
 =?us-ascii?Q?bwAwXKKRLBTDMQH0FufW8+uIDVYTt55YDtD2OvAO8qfVpCdmtchCuYZsv56M?=
 =?us-ascii?Q?1jPUeG4xpaMeGNze/X/p/XDU+ptR9o4kyrsUpdBpx5XYYLxJqZEKlvMis+LM?=
 =?us-ascii?Q?MhjT9tx5ARV5SWI38iU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721cb7c5-b446-434e-b8bb-08db1b236b80
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 13:38:34.3829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGYQcxoNXebk7vsoDvOexjvYDnKocYG41jIrw5BWFh7rTHsjjAxt4ZAksZoEGPcf3dBth0aaICLiIWRuwQYZ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007
Subject: [virtio-dev] RE: [PATCH v10 00/10] Introduce device group and device management


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, March 2, 2023 8:05 AM
> Change log:
>=20
> since v9:
This version is supposed to be v11 from last v10 [1].
https://lists.oasis-open.org/archives/virtio-dev/202302/msg00174.html

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

